# ~/.config/fish/config.fish

# 1. Homebrew-ympäristö (Ajetaan KAIKISSA sessioissa, myös skripteissä)
if test -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# 2. Vain interaktiiviset sessiot (pääte, kursorit, teemat jne.)
if status is-interactive
    # Starship-promptin alustus
    starship init fish | source
end
