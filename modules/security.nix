{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "slab_nomerge"
    "slub_debug=FZ"
    "page_alloc.shuffle=1"
    "vsyscall=none"
  ];

  security.protectKernelImage = true;
  security.forcePageTableIsolation = true;

  systemd.services.isolated-vault = {
    description = "Example Sandboxed Service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.coreutils}/bin/sleep infinity";
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
      PrivateDevices = true;
      MemoryDenyWriteExecute = true;
      RestrictRealtime = true;
    };
  };
}
