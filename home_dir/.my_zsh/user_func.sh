my_get_active_player() {
  PLAYER=""
  for l in  $(playerctl -l 2>/dev/null); do
    STAT=`playerctl -p $l status 2>/dev/null`
    if [ $STAT = "Playing" ]; then
      PLAYER="$l"
    fi
  done

  echo $PLAYER
}

my_print_my_zsh_aliases() {
	bat $MY_ZSH/aliases.zsh | fzf
}

kde_set_wall()
{
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var Desktops = desktops();
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper",
                                    "org.kde.image",
                                    "General");
        d.writeConfig("Image", "file://'"$1"'");
}'
}

kde_set_wall_url()
{
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var Desktops = desktops();
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper",
                                    "org.kde.image",
                                    "General");
        d.writeConfig("Image", "'"$1"'");
}'
}
