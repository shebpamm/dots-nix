{ ... }:
{
  flake.wrappers.kubectl = { wlib, pkgs, ... }:
    {
      imports = [ wlib.modules.default ];


      config = {
        package = pkgs.kubecolor;
        binName = "kubectl";
        env.KUBECOLOR_KUBECTL = "${pkgs.kubectl}/bin/kubectl";
        env.KUBECTL_EXTERNAL_DIFF = "${pkgs.dyff}/bin/dyff between --color on";
      };
    };
}
