# Global settings
set-option -g history-limit 10000
set -g mode-mouse on
set -g mouse-resize-pane on
set -g default-terminal 'screen-256color'
set-window-option -g utf8 on

# Turn on vim mode
set-window-option -g mode-keys vi

# Vim-like copy
bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection

# Screen-like prefix
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Screen-like detach
unbind ^D
bind ^D detach

# Intuitive splits
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Intuitive pane-switching
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
