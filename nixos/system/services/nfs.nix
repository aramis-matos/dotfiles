{ ... }:
{
  services.nfs.server = {
    enable = true;
    exports = ''
      /export/Downloads/ *(rw,sync,no_subtree_check)
    '';
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
  };
}
