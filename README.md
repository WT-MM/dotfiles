# dotfiles

Repo for managing my dotfiles across several environments.

## Installation

```sh
git clone git@github.com:WT-MM/dotfiles.git && cd dotfiles && ./install
```

## Related

- I borrowed a lot of this repo from [here](https://github.com/mikejqzhang/dotfiles)
- It's based on DotBot [here](https://github.com/anishathalye/dotbot)

## Documentation

Here are some of the additional commands in these dotfiles, besides the housekeeping-type improvements.

### prof

Profile directory (useful for finding large files):

```bash
prof (<dir-name>)
```

### mkcd

Make directory, then `cd` to that directory

```bash
mkcd <dir-name>
```

### gdrive

Download file from Google drive:

```bash
gdrive <google-fid> <output-path>
```

### topc

Filter `top` for process name regex:

```bash
topc <regex>
```

### conda

Edit Conda environment variables:

```bash
cvars (rm {r}) (rm-activate {ra}) (rm-deactivate {rd}) (activate {a}) (deactivate {d})
```

Activate Conda environment (alias for `conda activate`, with tab completion):

```bash
cenv <env-name>
```

### tmp-script

Create a new temporary script:

```bash
tinit <script-name>
```

Edit a script (with tab completion):

```bash
tedit <script-name>
```

Run a temporary script (with tab completion):

```bash
trun <script-name>
```

Delete a script (with tab completion):

```bash
tdelete <script-name>
```

### slurm

Show all my current Slurm jobs:

```bash
squeueme
```

Safely cancel all my current Slurm jobs:

```bash
scancelme
```

### nvidia

Track NVIDIA GPU usage:

```bash
smi
```

### tmux

Create a named `tmux` session:

```bash
tmuxn <name>
```

Attach to `tmux` as an iTerm2 window (with tab completion for session name):

```bash
tmuxc <name>
```

### ssh

Add this in your `~/.ssh/config` file to prevent having to re-authenticate when SSH'ing (useful for 2FA):

```bash
Include config.d/base
```

By default, Jupyter notebooks will be served on port 16012. Therefore, it's a good idea to add this port forwarding to your SSH config file:

```bash
LocalForward 16012 localhost:16012
```

### make

Build a file, and if make succeeds, run it (currently NVCC and C / C++). Useful for programming competitions, test scripts, etc.

```bash
brun <fname> (runtime-args)
```
