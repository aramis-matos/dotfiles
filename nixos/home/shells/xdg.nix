{...}: {
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "application/xhtml+xml" = "librewolf.desktop";
            "text/html" = "librewolf.desktop";
            "text/xml" = "librewolf.desktop";
            "x-scheme-handler/ftp" = "librewolf.desktop";
            "x-scheme-handler/http" = "librewolf.desktop";
            "x-scheme-handler/https" = "librewolf.desktop";
        };
    };
}