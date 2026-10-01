function dokutpdfksi
    for file in $argv
        lowriter --headless --convert-to pdf "$file"
    end
end
