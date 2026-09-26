gf() {
    if [ "$1" = "repo" ]
    then
        if [ -z "$2" ]
        then
            echo "usage: gf repo <name>"
            return 1
        fi

        repo="$2"

        path=$(find ~ -maxdepth 3 -type d -name ".git" 2>/dev/null |
        while read -r gitfolder
        do
            folder=$(dirname "$gitfolder")
            name=$(basename "$folder")

            if [ "$name" = "$repo" ]
            then
                echo "$folder"
                break
            fi
        done)

        if [ -z "$path" ]
        then
            echo "warning: repository not found"
            return 1
        fi

        cd "$path"
        return 0
    fi

    ~/.local/bin/gf "$@"
}
