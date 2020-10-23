with import <nixpkgs> {};

vim_configurable.customize {
    name = "vi";
    vimrcConfig.customRC = ''
      set number
      set relativenumber
    '';
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
    vimrcConfig.vam.pluginDictionaries = [
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/vim-plugin-names
      { names = [
        "Syntastic"
	"ctrlp"
	"vim-nix"
      ]; }
    ];
}
