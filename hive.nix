{
  meta = {
    nixpkgs = <nixpkgs>;
  };

  defaults = { pkgs, ... }: {
    # This module will be imported by all hosts
    environment.systemPackages = with pkgs; [
      curl
      htop
      tmux
      vim 
      wget
      python310
    ];
  };

  neurolink = ./hosts/neurolink;
}

