{ config, lib, ... }:

with lib;

let
  cfg = config.services.rusty-blog;
  pkgs = import <nixpkgs> { overlays = [(import ./overlays/rust-overlay.nix) (import ./overlays/rusty-blog-overlay.nix)]; };
in {
  options.services.rusty-blog = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If enabled, it will run the rusty-blog server
      '';
    };
    documentRoot = mkOption {
      type = types.str;
      description = ''
        Path to the content of the blog
      '';
    };
    context = mkOption {
      type = types.str;
      default = "http://localhost:8080/";
      description = ''
        Where it is hosted
      '';
    };
    user = mkOption {
      type = types.str;
      description = ''
        Which user should run the server
      '';
    };

  };
  config = {
    systemd.services.rusty-blog = mkIf cfg.enable
      { description = "Rusty blog service";
        path = [ pkgs.su pkgs.rusty-blog ];
        script =
          ''
            echo doc_path: ${cfg.documentRoot} > config.yml
            echo context: ${cfg.context} >> config.yml
            echo all_posts: false >> config.yml
            echo test > ${cfg.documentRoot}/testfile
            exec su ${cfg.user} -c "PATH=$PATH rusty-blog"
          '';
        wantedBy = [ "multi-user.target" ];
      };
      
  };
        
}   

