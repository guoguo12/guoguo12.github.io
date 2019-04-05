# Config for tmux 2.6

# Global settings
set -g mouse on
set-option -g history-limit 100000
set -g default-terminal 'screen-256color'

# Turn on vim mode
set-window-option -g mode-keys vi

# Vim-like copy
bind -T copy-mode-vi 'v' send -X begin-selection
bind -T copy-mode-vi 'y' send -X copy-selection

# Vim-like copy (older versions of tmux)
# bind-key -t vi-copy 'v' begin-selection
# bind-key -t vi-copy 'y' copy-selection

# Screen-like prefix
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Screen-like detach
unbind ^D
bind ^D detach

# Intuitive splits
bind | split-window -h
bind - split-window -v -p 85
unbind '"'
unbind %

# For sending keystrokes to multiple panes
bind -n M-s setw synchronize-panes

# Intuitive pane-switching
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Vim-like pane-switching
bind -n M-h select-pane -L
bind -n M-l select-pane -R
bind -n M-k select-pane -U
bind -n M-j select-pane -D

# Status bar styling
set -g status-bg "#101010"
set -g status-fg "#BA68C8"
setw -g window-status-current-fg white

# Clock styling
setw -g clock-mode-colour colour5

# Other settings for older versions of tmux
# set -g mode-mouse on
# set -g mouse-resize-pane on
# set-window-option -g utf8 on
