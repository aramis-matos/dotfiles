{...}:
{

  # Enable the X11 windowing system.
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
    Option "VariableRefresh" "true"
    Option "AsyncFlipSecondaries" "true"
  '';
  services.xserver.exportConfiguration = true;
}