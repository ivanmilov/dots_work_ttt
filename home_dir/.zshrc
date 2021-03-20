# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/i/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(extract fzf zsh-autosuggestions zsh-history-substring-search git-extras
	# globalias #### see user_func
	fd autoupdate colored-man-pages
	history-search-multi-word
	fast-syntax-highlighting
	)

#### custom plugins links ###
# autoupdate -> https://github.com/TamCore/autoupdate-oh-my-zsh-plugins
# zsh-autosuggestions -> https://github.com/zsh-users/zsh-autosuggestions
# zsh-history-substring-search -> https://github.com/zsh-users/zsh-history-substring-search
# bazel -> https://github.com/jackwish/bazel
# fast-syntax-highlighting -> https://github.com/zdharma/fast-syntax-highlighting.git
# history-search-multi-word -> https://github.com/zdharma/history-search-multi-word
#### custom plugins links END ###
source $ZSH/oh-my-zsh.sh

export MY_ZSH="/home/i/.my_zsh"

source $MY_ZSH/basic.zsh
source $MY_ZSH/user_func.sh
source $MY_ZSH/user_func.zsh
source $MY_ZSH/aliases.zsh
source $MY_ZSH/aliases_work.zsh
### fzf ###
# preview
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || batcat --style=numbers --color=always {} || tree -C {}) 2> /dev/null | head -50'"

# When using a custom FZF_CTRL_T_COMMAND, use the unexpanded $dir variable to make use of this feature. $dir defaults to . when the last token is not a valid directory.
# set -g FZF_CTRL_T_COMMAND "command find -L \$dir 2> /dev/null | sed '1d; s#^\./##'"
export FZF_CTRL_T_COMMAND='fdfind -H --type f --no-ignore-vcs'
export FZF_ALT_C_COMMAND='fdfind -H'

### fzf END ###

### p10k ###
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

####################################[ My p10k prefs ]####################################
  # Blue prompt symbol if the last command failed.
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=39

  # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
  # when accepting a command line. Supported values:
  #
  #   - off:      Don't change prompt when accepting a command line.
  #   - always:   Trim down prompt when accepting a command line.
  #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
  #               typed after changing current working directory.
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

  # https://github.com/romkatv/powerlevel10k#extra-space-without-background-on-the-right-side-of-right-prompt
ZLE_RPROMPT_INDENT=0

# After 'p10k configure' change value 32 in function my_git_formatter() to at least 60 to not shortening branch name
### p10k END ###


# *-magic is known buggy in some versions; disable if so
# disable the code from ~/.oh-my-zsh/lib/misc.zsh
DISABLE_MAGIC_FUNCTIONS=true
