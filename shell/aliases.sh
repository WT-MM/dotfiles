# C++ flags for programming competitions.
export CXXFLAGS="-Wall -Wextra -O2 -pedantic -std=c++11"

# grep
alias grep='grep --color'

# ls
alias ll='ls -lah'
alias la='ls -A'

# protect against overwriting
alias cp='cp -i'
alias mv='mv -i'

# clear
alias cl='clear'

# nvidia
alias smi='watch -n1 nvidia-smi'

# tmux
tmuxn() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: tmuxn <new-session-name>"
        exit 1
    fi
    tmux new-session -d -s $1
    tmux -CC attach -t $1
}

# time
alias today='date +"%Y-%m-%d'
alias now='date +"%T"'

# slurm
alias squeueme='squeue -u $USER'
alias sshareme='sshare -u $USER'

# cuda
export TORCH_CUDA_ARCH_LIST="6.0;7.0"

# filter top for process regex
topc() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: topc <regex>"
        exit 1
    fi
    top -c -p $(pgrep -d',' -f $1)
}

# update dotfiles
dfu() {
    if [[ $# -ne 0 ]]; then
        echo "Updates dotfiles. Usage: dfu"
        exit 1
    fi

    cd ~/.dotfiles
    git pull --ff-only
    ./install -q
}

# profile directory
prof() {
    if [[ $# -ne 0 ]]; then
        DEPTH=$1
        shift
    else
        DEPTH=4
    fi
    du -h -d $DEPTH | sort -h
}

# for downloading files from google drive
function gdrive {
    if [[ $# -ne 2 ]]; then
        echo "Usage: gdrive <fid> <fpath>"
        return 1
    fi
    FILEID="$1"
    FILENAME="$2"
    O=$(wget \
        --quiet \
        --save-cookies /tmp/cookies.txt \
        --keep-session-cookies \
        --no-check-certificate \
        "https://docs.google.com/uc?export=download&id=${FILEID}" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
    wget \
        --load-cookies /tmp/cookies.txt \
        "https://docs.google.com/uc?export=download&confirm=${O}&id=${FILEID}" -O $FILENAME
    rm -rf /tmp/cookies.txt
    return 0
}
