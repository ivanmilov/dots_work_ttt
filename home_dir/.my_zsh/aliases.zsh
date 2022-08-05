# alias ll="ls -lah"
alias ll="exa -lahg --icons --git"
alias gg="git gui &"
alias gs="git status"
alias gti="git"
alias gb="git branch"
alias gp="git pull"
alias gpr="git pull -r"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset %C(italic #606060) sign[%G?]' --abbrev-commit --no-merges"
alias gco="git checkout"
alias gw="git whatchanged"

alias fd=fdfind
alias bat=batcat

alias sm="/opt/sublime_merge/sublime_merge %F"
alias resetkr="pkill krunner; krunner&; disown"

alias bb="bazel build --jobs=8 "
alias bbd="bazel build --jobs=8 -c dbg "
alias bt="bazel test --jobs=8 --nocache_test_results --test_output=all "
alias btd="bazel test --jobs=8 -c dbg --nocache_test_results --test_output=all  "
alias br="bazel run --jobs=8 --nocache_test_results "
