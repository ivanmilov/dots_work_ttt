# dots_work_ttt

```bash
cd ~/dots_work_ttt
sudo mount -B ~/ home_dir/
```
## [git-crypt](https://github.com/AGWA/git-crypt)
```bash
gpg --list-secret-keys --keyid-format LONG
gpg --export -a "Your Name" > other_user_pub.key
# send other_user_pub.key to the 'admin'
...
gpg --import other_user_pub.key
git-crypt add-gpg-user --trusted AAABBBCCC_key_id
git push
...
git-crypt unlock
...
git-crypt status -e
```


## Addons
* [alacritty](https://github.com/alacritty/alacritty)
* [autotiling](https://github.com/nwg-piotr/autotiling)
* [i3bloks](https://github.com/ivanmilov/i3blocks)
* [picom](https://github.com/yshui/picom)
* [playerctl](https://github.com/altdesktop/playerctl)
* [spotify_remote](https://github.com/ivanmilov/spotify_remote) for media blocks
* [telegram_test_message_bot](https://github.com/ivanmilov/telegram_test_message_bot) for timer block
* [xkblayout-state](https://github.com/nonpop/xkblayout-state) for lock.sh
* fonts
  * [FiraCode](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
  * [MesloLGS](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) for zsh
## zsh
* [fdfind](https://github.com/sharkdp/fd#installation)
* [fzf](https://github.com/junegunn/fzf)
* [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
  * [autoupdate](https://github.com/TamCore/autoupdate-oh-my-zsh-plugins)
  * [bazel](https://github.com/jackwish/bazel)
  * [fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting.git)
  * [history-search-multi-word](https://github.com/zdharma/history-search-multi-word)
  * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  * [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
* theme
  * [powerlevel10k](https://github.com/romkatv/powerlevel10k)
