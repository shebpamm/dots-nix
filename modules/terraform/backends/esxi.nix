{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      esxi = {
        nixos =
          {
            pkgs,
            lib,
            config,
            ...
          }:
          {
            options.server.esxi-image = lib.mkOption {
              type = lib.types.package;
              description = "ESXi compatible OVF image, built from virtualbox image and patched cot.";
            };
            config =
              let
                ovftool = pkgs.ovftool.override { acceptBroadcomEula = true; }; # sell soul to broadcom
              in
              {
                server.esxi-image = pkgs.runCommand "nixovabase" { } ''
                  ova=${config.system.build.images.virtualbox}/*.ova
                  mkdir $out
                  ${pkgs.cot}/bin/cot --force --verbose edit-product $ova -p 'Some Info' -o nixos.ova
                  ${pkgs.cot}/bin/cot --force --verbose edit-hardware nixos.ova -v vmx-13
                  tar xf nixos.ova
                  sed -i -E 's/^(\s*<(ovf:)?ProductSection)>\s*$/\1 ovf:required="false">/' *.ovf
                  sed -i -E "s/^(SHA1\(nixos.ovf\)=\s*).*$/\1$(sha1sum nixos.ovf | cut -d ' ' -f 1)/" *.mf
                  ${ovftool}/bin/ovftool --lax --sourceType=OVF --targetType=OVA nixos.ovf $out/nixos.ova
                '';
              };
          };
        terraform =
          {
            name,
            config,
            lib,
            ...
          }:
          {
            options.server.specs = {
              cpus = lib.mkOption {
                type = lib.types.int;
                default = 8;
                description = "Number of CPUs to allocate to the VM.";
              };

              memory = lib.mkOption {
                type = lib.types.int;
                default = 4096;
                description = "Amount of memory (in MB) to allocate to the VM.";
              };

              disk = lib.mkOption {
                type = lib.types.int;
                default = 20;
                description = "Size of the data disk (in GB) to allocate to the VM. OS disk is set at 32 GB.";
              };
            };

            options.server.image = lib.mkOption {
              type = lib.types.path;
              default = inputs.self.nixosConfigurations.${name}.config.server.esxi-image + "/nixos.ova";
              description = "NixOS image to deploy on the VM.";
            };

            config = {
              locals = {
                vsphere_username = "\${file(\"/var/run/secrets/vsphere-username\")}";
                vsphere_password = "\${file(\"/var/run/secrets/vsphere-password\")}";
                vsphere_server = "\${file(\"/var/run/secrets/vsphere-hostname\")}";
              };

              terraform.required_providers.vsphere = {
                source = "local/hashicorp/vsphere";
                version = "2.13.0";
              };

              provider.vsphere = {
                user = "\${local.vsphere_username}";
                password = "\${local.vsphere_password}";
                vsphere_server = "\${local.vsphere_server}";
                allow_unverified_ssl = true;
              };

              data.vsphere_datacenter.datacenter = {
                name = "ha-datacenter";
              };

              data.vsphere_datastore.datastore = {
                datacenter_id = "\${data.vsphere_datacenter.datacenter.id}";
                name = "Main Storage";
              };

              data.vsphere_resource_pool.pool = {
                name = "Virtual Machines";
                datacenter_id = "\${data.vsphere_datacenter.datacenter.id}";
              };

              data.vsphere_network.network = {
                name = "Virtual Machines";
                datacenter_id = "\${data.vsphere_datacenter.datacenter.id}";
              };

              resource.vsphere_virtual_machine.${name} = {
                inherit name;
                count = 1;
                num_cpus = config.server.specs.cpus;
                memory = config.server.specs.memory;
                guest_id = "OtherGuest64";
                datastore_id = "\${data.vsphere_datastore.datastore.id}";
                resource_pool_id = "\${data.vsphere_resource_pool.pool.id}";
                datacenter_id = "\${data.vsphere_datacenter.datacenter.id}";
                host_system_id = "ha-host";
                network_interface = {
                  network_id = "\${data.vsphere_network.network.id}";
                };
                disk = {
                  label = "data";
                  size = config.server.specs.disk;
                };
                cdrom = {
                  datastore_id = "\${data.vsphere_datastore.datastore.id}";
                  path = "sops-secrets.iso";
                };
                ovf_deploy = {
                  allow_unverified_ssl_cert = true;
                  local_ovf_path = config.server.image;
                  disk_provisioning = "thin";
                };
                lifecycle = {
                  ignore_changes = [ "disk[0].io_share_count" ];
                };
              };

            };
          };
      };
    };
}
