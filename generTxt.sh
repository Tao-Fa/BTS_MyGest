#!/bin/bash

# mission 3 partie 2

# Paramètre de connection à la base de donnés

DB_HOST="localhost"     # Adresse du serveur MySQL
DB_USER="root"   # Nom D'utilisateur
DB_Pass=""  # Mot de passe
DB_Name="MyGest"    # Nom de la base de données
Output_File="données_BDD" #Nom de sortie du fichier


# Requête SQL pour récupérer les adresses IP des machines
QUERRY="SELECT * FROM MyGest.Equipement;"

#Exécution de la requête et enregistrement des resultats dans le fichier
mysql -u root -e "USE MyGest";
mysql -h "$DB_HOST" -u "$DB_USER" -p "$DB_Pass" -D "$DB_Name" -Bse "$QUERRY" > "$Output_File" 

# vérification et message de confirmation

#if [ $? -eq 0]; then
#    echo "le fichier "$Output_File" a été généré avec succès !"
#else
#    echo "Erreur lors de la génération du fichier."
#fi