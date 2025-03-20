Warning the file menuoutils.sh is no quite ready 
attention le fichier menuoutils.sh n'est pas complet il ne fonctionne pas avec certain script





Projet : Menu Bash Interactif
=================================

Ce projet consiste en la création d'un script Bash interactif permettant d'exécuter différents fichiers Bash selon les besoins de l'utilisateur.

Fichiers inclus :
-----------------
- checkValid.sh : Vérifie la validité de certaines données, comme des adresses e-mail, des noms d'utilisateur ou d'autres entrées spécifiques.
- generTxt.sh : Génère un fichier texte avec du contenu personnalisé, en fonction de paramètres ou d'une logique prédéfinie.
- testIP.sh : Vérifie si une adresse IP donnée est valide et teste sa connectivité en utilisant des commandes réseau comme ping.
- menu.sh : Script principal qui affiche un menu interactif permettant d'exécuter les scripts ci-dessus en fonction du choix de l'utilisateur.

Fonctionnement :
---------------
Un menu interactif est affiché à l'utilisateur, lui permettant de choisir l'un des scripts à exécuter. Il peut également quitter le programme.

Contenu des Scripts :
----------------------

checkValid.sh :
---------------
#!/bin/bash

#Définition des couleurs pour l'affichage
GREEN='\033[0;32m'  # Texte en vert pour les IP actives

RED='\033[0;31m'    # Texte en rouge pour les IP inactives

NC='\033[0m'        # Réinitialisation de la couleur (No Color)

#Fichier contenant les adresses IP à tester
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




generTxt.sh :
-------------
#!/bin/bash

# mission 3 partie 2

# Paramètre de connection à la base de données

DB_HOST="localhost"     # Adresse du serveur MySQL
DB_USER="root"   # Nom d'utilisateur
DB_Pass=""  # Mot de passe
DB_Name="MyGest"    # Nom de la base de données
Output_File="données_BDD" #Nom de sortie du fichier

# Requête SQL pour récupérer les adresses IP des machines
QUERRY="SELECT * FROM MyGest.Equipement;"

# Exécution de la requête et enregistrement des résultats dans le fichier
mysql -u root -e "USE MyGest";
mysql -h "$DB_HOST" -u "$DB_USER" -p "$DB_Pass" -D "$DB_Name" -Bse "$QUERRY" > "$Output_File" 

--------------------------------------

testIP.sh :
-----------
#!/bin/bash

read -p "Entrez une adresse IP ou un domaine :" cible

if ping -c 4 "$cible" > /dev/null 2>&1; then
    echo "La cible $cible est accessible."
else
    echo "La cible $cible ne répond pas."
fi


menuOutils.sh
-------------
#!/bin/bash
clear
while true; do
echo ""
    echo "===== Menu ====="
    echo "1. testIP.sh"
    echo "2. testTCP.sh"
    echo "3. generTxt.sh"
    echo "4. checkValid.sh"
    echo "5. quitter"
    echo "================"
    read -p "Choisissez une option : " choix

    case $choix in
        1) 
            ./testIP.sh
	 ;;
        2) 
            ./testTCP.sh
	 ;;
        3)
            ./generTxt.sh
	 ;;
        4)
            ./checkValid.sh
	 ;;
        5) 
            echo "Au revoir !"
            exit 0 ;;
        *) 
            echo "Option invalide, essayez encore."
            sleep 2 ;;
    esac
done
