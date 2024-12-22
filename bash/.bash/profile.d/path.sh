FLATPAK_APPLICATIONS_DIRS="/var/lib/flatpak/exports/share/applications:$HOME/.local/share/flatpak/exports/share/applications:$HOME/local/share/flatpak/exports/share/applications"
FLATPAK_BIN_DIRS="/var/lib/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin:$HOME/local/share/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin"
FLATPAK_SHARE_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$HOME/local/share/flatpak/exports/share"

XDG_CONFIG_DIRS="$FLATPAK_APPLICATIONS_DIRS"
XDG_DATA_DIRS="$FLATPAK_SHARE_DIRS:$FLATPAK_APPLICATIONS_DIRS:$XDG_DATA_DIRS"

