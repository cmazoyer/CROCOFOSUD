#!/bin/bash

# Vérifie si ImageMagick est installé
command -v convert >/dev/null 2>&1 || { echo >&2 "ImageMagick n'est pas installé. Installez-le d'abord."; exit 1; }

# Vérifie si le nombre d'arguments est correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Récupère le répertoire spécifié
directory="$1"

# Vérifie si le répertoire existe
if [ ! -d "$directory" ]; then
    echo "Le répertoire spécifié n'existe pas."
    exit 1
fi

# Parcours tous les fichiers JPG dans le répertoire
for file in "$directory"/*.JPG; do
    if [ -f "$file" ]; then
        # Réduit la taille du fichier JPG et le renomme avec le suffixe "_small"
        filename=$(basename "$file")
        extension="${filename##*.}"
        filename_noext="${filename%.*}"
        new_filename="${filename_noext}_small.$extension"
        convert "$file" -resize 50% "$directory/$new_filename"
        echo "Le fichier $filename a été réduit et renommé en $new_filename."
    fi
done

echo "La réduction de taille et le renommage des fichiers JPG dans le répertoire $directory sont terminés."

