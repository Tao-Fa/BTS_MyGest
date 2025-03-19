#!/bin/bash


read -p "entrez une adresse ip ou un domaine :" cible

if ping -c 4 "$cible" > /dev/null 2>&1; then
    echo "la cible $cible est accessible."
else
    echo "la cible $cible ne repond pas."
fi