#!/bin/bash

# Ajo vain Ubuntulla / Debianilla / Pop!_OS:lla
# Muuttuja johon peruspaketit listataan
declare -a basic_packages=(
    curl
    git
    build-essential
    htop
    fish
    vim
    zsh
    rsync
    tree
    btop
    bat
    eza
    zsh-autosuggestions
    zsh-syntax-highlighting
)

confirm() {
    local prompt="$1"
    local response
    while true; do
        read -r -p "$prompt [k/e]: " response < /dev/tty
        case "$response" in
            [Kk]* ) return 0;;
            [Ee]* ) return 1;;
            * ) echo "Vastaa 'k' (kyllä) tai 'e' (ei).";;
        esac
    done
}

if confirm "Haluatko asentaa ohjelmapaketit (mukaan lukien Element Desktop, Fish, CLI-työkalut)?"; then

# --- Element Desktop ---
if ! command -v element-desktop &> /dev/null; then
    echo "element-desktop ei ole asennettu, asennetaan..."
    sudo apt update && sudo apt install -y wget apt-transport-https
    sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
    sudo apt update
    sudo apt install -y element-desktop
else
    echo "Element Desktop on jo asennettu."
fi

# Tarkistetaan ennen asennusta, ovatko peruspaketit jo asennettu
for package in "${basic_packages[@]}"; do
    if ! dpkg -s "$package" &> /dev/null; then
        echo "$package ei ole asennettu, asennetaan..."
        sudo apt install -y "$package"
    else
        echo "$package on jo asennettu."
    fi
done

HOST_NAME="$(cat /etc/hostname 2>/dev/null | tr -d '[:space:]')"

if [[ "lakka" != "$HOST_NAME" ]]; then
    # --- Vaihdetaan Oletusshell (Fish) ---
    FISH_PATH="$(which fish)"
    if [[ "$FISH_PATH" != "$(getent passwd "$USER" | cut -d: -f7)" ]]; then
        echo "Asetetaan Fish oletusshelliksi..."

        # Varmistetaan että fish löytyy /etc/shells-tiedostosta ennen chsh-komentoa
        if ! grep -q "$FISH_PATH" /etc/shells; then
            echo "$FISH_PATH" | sudo tee -a /etc/shells
        fi

        chsh -s "$FISH_PATH"
    else
        echo "Fish on jo oletusshell."
    fi
fi

# --- 5. Starship-promptin asennus ---
if ! command -v starship &> /dev/null; then
    echo "Asennetaan Starship-prompt..."
    # Varmistetaan, että kohdehakemisto on olemassa
    mkdir -p "$HOME/.local/bin"
    # Asennetaan Starship käyttäjän kotihakemiston .local/bin-kansioon ilman sudoa
    sh -c "$(curl -sS https://starship.rs/install.sh)" -- -y -b "$HOME/.local/bin"
fi

