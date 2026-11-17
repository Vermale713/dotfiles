if status is-interactive
    # Starship prompt
    starship init fish | source

    # Disable greeting
    set -g fish_greeting
end
