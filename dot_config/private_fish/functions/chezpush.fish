function chezpush
    set -l msg $argv[1]
    if test -z "$msg"
        set msg "Update dotfiles"
    end

    chezmoi git add .
    and chezmoi git commit -- -m "$msg"
    and chezmoi git push
    and chezmoi apply
end
