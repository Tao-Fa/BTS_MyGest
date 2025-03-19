#!/bin/bash

# Définition des couleurs pour l'affichage
GREEN='\033[0;32m'  # Texte en vert pour les IP actives
RED='\033[0;31m'    # Texte en rouge pour les IP inactives
NC='\033[0m'        # Réinitialisation de la couleur (No Color)
# Fichier contenant les adresses IP à tester
IP_LIST="données_BDD"

# Vérifier que Nmap est installé
if ! command -v nmap &> /dev/null; then
    echo "Erreur : Nmap n'est pas installé. Installe-le avec : sudo apt install nmap"
    exit 1
fi

# Vérifier que le fichier contenant les IP existe
if [[ ! -f "$IP_LIST" ]]; then
    echo "Le fichier $IP_LIST n'existe pas !"
    exit 1
fi

# Boucle qui lit chaque ligne du fichier contenant les adresses IP
while IFS= read -r ip; do
    # Utilisation de Nmap pour détecter si l'IP est active
    if nmap -sn "$ip" | grep -q "Host is up"; then
        echo -e "${GREEN}[✔] $ip est ACTIVE${NC}"
    else
        echo -e "${RED}[✘] $ip est INACTIVE${NC}"
    fi
done < "$IP_LIST"
