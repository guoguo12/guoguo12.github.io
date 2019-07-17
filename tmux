# Config for tmux 2.6+
# Reload with ":source-file ~/.tmux.conf"

# Global settings
set -g mouse on
set-option -g history-limit 100000
set -g default-terminal 'screen-256color'

# Turn on vim mode
set-window-option -g mode-keys vi

# Vim-like copy
bind -T copy-mode-vi 'v' send -X begin-selection
bind -T copy-mode-vi 'y' send -X copy-selection

# Copy to system clipboard
bind -T copy-mode-vi C-y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

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
# bind -n M-h select-pane -L
# bind -n M-l select-pane -R
# bind -n M-k select-pane -U
# bind -n M-j select-pane -D

# Status bar styling
set -g status-style bg="#101010",fg="#BA68C8"
setw -g window-status-current-style fg=white

# Status bar contents
set -g status-interval 1
set -g status-right '%a %b %_d %Y %H:%M:%S'

# Clock styling
setw -g clock-mode-colour colour5

# Swap-window shortcuts
bind-key -n C-S-Left swap-window -t -1
bind-key -n C-S-Right swap-window -t +1

# Other settings for older versions of tmux
# set -g mode-mouse on
# set -g mouse-resize-pane on
# set-window-option -g utf8 on
