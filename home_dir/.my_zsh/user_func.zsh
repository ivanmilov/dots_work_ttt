my_bazel_queue_fzf(){
	local query target new_querry command cur_target post_params

	setopt RE_MATCH_PCRE

	[[ $BUFFER =~ '([^\/]*)(\/\/[^\s]+)?\s*(--.+)?' ]] && command=$match[1] cur_target=$match[2] post_params=$match[3]

	if [ -z "$cur_target" ]
	then
		new_querry="//..."
		# new_querry="//..."

	else
		new_querry=$(echo "$cur_target" | sed 's: *$::' | sed 's:\.*$::' | sed 's:/*$::')
		new_querry="${new_querry}/..."
	fi

	query=$(bazel query ${new_querry} 2> /dev/null)
	target=$(echo "$query" | fzf +m)

	[[ -z "$target" ]] && target=$cur_target

	BUFFER=$(echo "${command}${target} ${post_params}")
	CURSOR=$#LBUFFER

	zle end-of-line
}

zle -N my_bazel_queue_fzf
bindkey "^b" my_bazel_queue_fzf								#{{# ctrl+b 		fzf bazel target

# fzf branch
fbr() {
  # local branches branch
  # branches=$(git --no-pager branch -vv) &&
  # branch=$(echo "$branches" | fzf +m) &&
  # git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  local branch
  branch=$(git branch |  cut -c 3- | fzf -m --preview="git log --color=always {} --")
  if [ -n "$branch" ]; then
    git checkout $branch
  fi
}

zle     -N   fbr
bindkey "^g^o" fbr											#{{# ctrl+g;ctrl+o 	fzf git checkout

# https://github.com/romkatv/zsh4humans/blob/master/.zshrc
# Widgets for changing current working directory.
function z4h-redraw-prompt() {
  emulate -L zsh
  local f
  for f in chpwd $chpwd_functions precmd $precmd_functions; do
    (( $+functions[$f] )) && $f &>/dev/null
  done
  zle .reset-prompt
  zle -R
}
function z4h-cd-rotate() {
  emulate -L zsh
  while (( $#dirstack )) && ! pushd -q $1 &>/dev/null; do
    popd -q $1
  done
  if (( $#dirstack )); then
    z4h-redraw-prompt
  fi
}
function z4h-cd-back() { z4h-cd-rotate +1 }
function z4h-cd-forward() { z4h-cd-rotate -0 }
function z4h-cd-up() { cd .. && z4h-redraw-prompt }

zle -N z4h-cd-back
zle -N z4h-cd-forward
zle -N z4h-cd-up

bindkey "^[[1;3D" z4h-cd-back								#{{# alt+left 	cd into the prev directory
bindkey "^[[1;3C" z4h-cd-forward							#{{# alt+right 	cd into the next directory
bindkey "^[[1;3A" z4h-cd-up									#{{# alt+up 		cd ..


# fzf-history-widget with duplicate removal, preview and syntax highlighting (requires `bat`).
function z4h-fzf-history-widget() {
  emulate -L zsh -o pipefail
  local preview='zsh -dfc "setopt extended_glob; echo - \${\${1#*[0-9] }## #}" -- {}'
  (( $+commands[bat] )) && preview+=' | bat -l bash --color always -pp'
  local selected
  selected="$(
    fc -rl 1 |
    awk '!_[substr($0, 8)]++' |
    fzf +m -n2..,.. --tiebreak=index --cycle --height=80% --preview-window=down:30%:wrap \
      --query=$LBUFFER --preview=$preview)"
  local -i ret=$?
  [[ -n "$selected" ]] && zle vi-fetch-history -n $selected
  zle .reset-prompt
  return ret
}

zle -N z4h-fzf-history-widget
bindkey "^R"      z4h-fzf-history-widget					#{{# ctrl+r 		fzf history


function z4h-run-help() { zle run-help || true }
zle -N z4h-run-help
bindkey "^[h"     z4h-run-help								#{{# alt+h 		help for the cmd at cursor
bindkey "^[H"     z4h-run-help								#{{# alt+H 		help for the cmd at cursor

bindkey "^N"      kill-buffer								#{{# ctrl+n  	delete all lines


# edit line in vim with ctrl+e
autoload edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line								#{{# ctrl+e 		edit with vim

# edit line in sublimeText with ctrl+e;ctrl+e
function my_subl_edit() {
  emulate -L zsh
  local VISUAL='subl -wn'
  edit-command-line
}

zle -N my_subl_edit
bindkey "^e^e" my_subl_edit									#{{# ctrl+e;ctrl+e 	edit with sublime


# Will return non-zero status if the current directory is not managed by git
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}


# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
my_gf() {
  is_in_git_repo || return
  out=$(git -c color.status=always status --short | \
  fzf -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' | \
  cut -c4- \
  | sed 's/.* -> //' )

   BUFFER="$BUFFER"$(echo "${out}")
}

my_gh() {
  is_in_git_repo || return
  # git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --color=always --no-merges |
  # fzf-down --ansi --no-sort --reverse --multi  \
  #   --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  # grep -o "[a-f0-9]\{7,\}"
  git log --oneline --color=always --date=short --pretty="format:%C(auto)%h %s %Cblue%an %C(green)%cd" "$@" | \
      fzf --reverse --exact --no-sort --ansi --preview 'git show -p --stat --pretty=fuller --color=always {1}'
}

zle -N my_gh
zle -N my_gf
bindkey "^g^h" my_gh 										#{{# ctrl+g;ctrl+h 	fzf git commit hashes
bindkey "^g^f" my_gf										#{{# ctrl+g;ctrl+f 	fzf git changed files


my_help() {
	# cat $MY_ZSH/user_func.zsh | sed -n -e 's/^.*#{{#\s\(.\+\).*/\1/p' |fzf
	typeset -A map

	kv=$(cat $MY_ZSH/user_func.zsh | sed -n -e 's/^.*\s\+".\+"\s\+\(\S\+\)\s\+#{{#\s\(.\+\)/\1 \2/p')
	echo $kv | while read k v; do map[$k]=$v; done

	fzf_list=""
	for value in ${(v)map}; do
		fzf_list="$(echo $value)\n$fzf_list"
	done

	selected=$(echo $fzf_list|fzf)

	for key value in ${(kv)map}; do
		if [ "$value" = "$selected" ]; then eval $key; fi
	done
}

zle -N my_help
bindkey "^h^h" my_help

bindkey "^R^R" history-search-multi-word					#{{# ctrl+r;ctrl+r 	history search multi word, NOT fzf


my_globalias() {
   zle _expand_alias
   zle expand-word
   # zle self-insert		### no need to insert ^@ {ctrl+space} to the end of line
}
zle -N my_globalias

# normal space during searches
bindkey -M isearch " " magic-space
# control-space expands all aliases, including global
bindkey "^ " my_globalias									#{{# ctrl+space 	expand all aliases
# space to make a normal space
bindkey " " magic-space


# source $MY_ZSH/user_func.zsh
zle -N my_print_my_zsh_aliases


my_clear() {
  clear
  zle .reset-prompt
}
zle -N my_clear
bindkey "^l" my_clear										#{{# ctrl+l 		clear
