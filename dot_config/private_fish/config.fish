# ~/.config/fish/config.fish

# 1. Homebrew-ympäristö (Ajetaan KAIKISSA sessioissa, myös skripteissä)
if test -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

if test -d ~/.linuxbrew
	eval (~/.linuxbrew/bin/brew shellenv)
end

#2.
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin

# 3. Vain interaktiiviset sessiot (pääte, kursorit, teemat jne.)
if status is-interactive
    # Starship-promptin alustus
    starship init fish | source
end
