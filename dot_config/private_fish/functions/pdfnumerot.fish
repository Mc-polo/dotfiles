function pdfnumerot
    if test (count $argv) -lt 1
        echo "Käyttö: pdfnumerot syöte.pdf [tuloste.pdf]"
        return 1
    end

    set -l input $argv[1]
    set -l output $argv[2]

    # Jos tulostenimeä ei annettu, käytetään muotoa syöte_numerotu.pdf
    if test -z "$output"
        set output (string replace -r '\.pdf$' '_numerotu.pdf' $input)
    end

    pdfcpu stamp add -mode text -- "Nipun sivu (%p/%P)" "scale:.6 abs, pos:bc, rot:0" $input $output
end
