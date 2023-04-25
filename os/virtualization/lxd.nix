{ config, pkgs, ... }:
{
  virtualisation.lxd = {
    enable = true;
    recommendedSysctlSettings = true;
  };

  environment.systemPackages = with pkgs; [ lxc ];


  users.extraGroups.lxd.members = [ "shebpamm" ];

  virtualisation.lxc.lxcfs.enable = true;
  networking.bridges = { lxdbr0.interfaces = [ ]; };

  networking.localCommands = ''
    ip address add 192.168.57.1/24 dev lxdbr0
  '';

  networking.firewall.extraCommands = ''
    iptables -A INPUT -i lxdbr0 -m comment --comment "my rule for LXD network lxdbr0" -j ACCEPT

    # These three technically aren't needed, since by default the FORWARD and
    # OUTPUT firewalls accept everything everything, but lets keep them in just
    # in case.
    iptables -A FORWARD -o lxdbr0 -m comment --comment "my rule for LXD network lxdbr0" -j ACCEPT
    iptables -A FORWARD -i lxdbr0 -m comment --comment "my rule for LXD network lxdbr0" -j ACCEPT
    iptables -A OUTPUT -o lxdbr0 -m comment --comment "my rule for LXD network lxdbr0" -j ACCEPT

    iptables -t nat -A POSTROUTING -s 192.168.57.0/24 ! -d 192.168.57.0/24 -m comment --comment "my rule for LXD network lxdbr0" -j MASQUERADE
  '';

  # ip forwarding is needed for NAT'ing to work.
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv4.conf.default.forwarding" = true;
  };

  # kernel module for forwarding to work
  boot.kernelModules = [ "nf_nat_ftp" ];
}
