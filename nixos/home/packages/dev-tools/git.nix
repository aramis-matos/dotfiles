{...}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "aramis-matos";
        email = "aramis.matos1@gmail.com";
      };
    };
    signing = {
      signByDefault = true;
      key = "0x3EF66A171C122736";
    };
  };
}