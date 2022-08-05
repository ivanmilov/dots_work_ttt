export SHELL=/bin/zsh

# This affects every invocation of `less`.
#
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS=-iRMx4

# Enable decent options. See http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt AUTO_CD                   # `dirname` is equivalent to `cd dirname`
setopt AUTO_PARAM_SLASH          # if completed parameter is a directory, add a trailing slash
setopt AUTO_PUSHD                # `cd` pushes directories to the directory stack
setopt COMPLETE_IN_WORD          # complete from the cursor rather than from the end of the word
# setopt BANG_HIST               # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
	# setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
	# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
	# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
	# setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
	# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
	# setopt HIST_BEEP                 # Beep when accessing nonexistent history.
	# setopt INTERACTIVE_COMMENTS      # allow comments in command line
	# setopt PATH_DIRS                 # perform path search even on command names with slashes
	# setopt C_BASES                   # print hex/oct numbers as 0xFF/077 instead of 16#FF/8#77
# setopt MULTIOS                 # allow multiple redirections for the same fd
# setopt NO_BG_NICE              # don't nice background jobs
# setopt NO_FLOW_CONTROL         # disable start/stop characters in shell editor
# setopt SHARE_HISTORY           # write and import history on every command
setopt localoptions rmstarsilent

# Make it possible to use completion specifications and functions written for bash.
autoload -Uz bashcompinit
compinit -D
bashcompinit
