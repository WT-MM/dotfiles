# .zshrc

# ---------------------------------
# Return for non-interactive shells
# ---------------------------------

if [ -z "$PS1" ]; then
    return
fi

# -----------
# Main config
# -----------

get_time() {
    if command -v python3 &> /dev/null; then
        python3 -c 'import time; print(round(time.time() * 1000))'
    else
        echo "0"
    fi
}

start_time=$(get_time)

if [ -f ~/.shell_local_before ]; then
    source ~/.shell_local_before
fi

if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

source ~/.zsh/plugins_before.zsh
source ~/.zsh/command_line.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/settings.zsh
source ~/.zsh/autocomplete.zsh
source ~/.zsh/plugins_after.zsh

source ~/.shell/update.sh
source ~/.shell/info.sh
source ~/.shell/aliases.sh

if [ -f ~/.shell_local_after ]; then
    source ~/.shell_local_after
fi

if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

source ~/.shell/path.sh

end_time=$(get_time)
time_delta=$(($end_time - $start_time))
if [ $time_delta -gt $SLOW_STARTUP_WARNING_MS ]; then
    warn-with-red-background "Startup took $time_delta milliseconds"
fi
