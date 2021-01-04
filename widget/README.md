## Widget
run_once({ "/usr/lib/xfce-polkit/xfce-polkit & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" }, { "xfce4-power-manager" }),
run_once({ "xfce4-power-manager" }),