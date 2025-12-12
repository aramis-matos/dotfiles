{ ... }:
{
services.keyd = {
  enable = true;
  keyboards = {
    # The name is just the name of the configuration file, it does not really matter
    default = {
      ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
      # Everything but the ID section:
      settings = {
        # The main layer, if you choose to declare it in Nix
        main = {
          capslock = "layer(fn)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
        };
        fn = {
	  "1" = "f1";
	  "2" = "f2";
	  "3" = "f3";
	  "4" = "f4";
	  "5" = "f5";
	  "6" = "f6";
	  "7" = "f7";
	  "8" = "f8";
	  "9" = "f9";
	  "0" = "f10";
	  "-" = "f11";
	  "=" = "f12";
	};
      };
      extraConfig = ''
        # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
      '';
    };
  };
};

}
