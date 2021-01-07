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
