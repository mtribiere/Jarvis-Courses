#!/bin/bash

## Fonction pour l'upload
jv_pg_lc_upload()
{

# Recupere le chemin du fichier
local path=$(pwd)/plugins_installed/Jarvis-Courses

# Uploader et voir le resultat

local result=$(curl --upload-file $path/liste.txt https://transfer.sh/)
# local result="https://transfer.sh/test"
local result=$(echo $result | grep 'https') 

# Afficher les résultats

if [ "$result" == "" ]
then
	say "Erreur lors de l'envoie !"
else
	if [ "$jv_pg_lc_printQRcode" == "True" ]
	then
		qrencode -s 20 -o $path/qrcode.png "$result" && sudo fbi -T 2 $path/qrcode.png
		say "Envoie réussi ! Le QR code s'affiche actuellement sur l'écran"
	else 
		say "Envoie réussi ! Le lien s'affiche actuellement sur l'écran"
		echo $result
	fi
fi


}

## Fonction pour afficher la liste
jv_pg_lc_print()
{

# Recupere le chemin du fichier
local path=$(pwd)/plugins_installed/Jarvis-Courses

# Verfier si la liste est vide

if [ "$(cat $path/liste.txt)" == "" ]
then 
	say "La liste est vide"
else
	say "La liste contient : "
	say "$(cat $path/liste.txt)"
fi

}
