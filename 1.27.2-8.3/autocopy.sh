#!/bin/bash

function create_symlinks() {

    local SOURCE_DIR=$1
    local DEST_DIR=$2
    for file in "$SOURCE_DIR"/*; do
        filename=$(basename "$file")
       
        skip=false 
        if [[ "$filename" == "Dockerfile" ]]; then
            skip=true
        fi
        
        if ! $skip; then
            cp -p "$file" "$DEST_DIR/$filename"
        fi
    done
}

dir=$(pwd)

create_symlinks "${dir}/php.dockerfile" "${dir}"
create_symlinks "${dir}/nginx.dockerfile" "${dir}"
