function chezpush
    set -l msg $argv[1]
    if test -z "$msg"
        set msg "Update dotfiles"
    end

    set -l source_dir (chezmoi source-path)

    # Lisätään muutokset suoraan gitillä lähdekansiossa
    git -C $source_dir add .

    # Commitataan vain jos muutoksia on
    if not git -C $source_dir diff --cached --quiet
        git -C $source_dir commit -m "$msg"
    else
        echo "Ei uusia muutoksia commitattavaksi."
    end

    # Lähetetään GitHubiin ja ajetaan apply
    git -C $source_dir push
    and chezmoi apply
end
