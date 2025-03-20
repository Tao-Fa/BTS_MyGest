#!/bin/bash

# Installer les dépendances nécessaires
#installer_dependances() {
    echo "Installation des dépendances nécessaires..."
    sudo apt update
    sudo apt install -y mariadb-server php php-mysqli php-xml
  mysql CREATE USER IF NOT EXIST "root"@"localhost" IDENTIFIED BY "";

# Connexion à la base de données MariaDB
#conn_bd() {
    #mysql CREATE USER IF NOT EXIST root IDENTIFIED BY "";
 #   DB_USER="root"
  #  DB_PASS=""
   # DB_NAME="MyGest"
    #mysql -u$DB_USER -p$DB_PASS
#}

# Création de la base de données et des tables
#creer_bdd_et_tables() {
    echo "Création de la base de données et des tables..."

    mysql -u root <<EOF
    CREATE DATABASE IF NOT EXISTS MyGest;

    USE MyGest;

    CREATE TABLE IF NOT EXISTS TypeE (
        ID INT NOT NULL AUTO_INCREMENT,
        libelle VARCHAR(50),
        PRIMARY KEY (ID)
    );

    CREATE TABLE IF NOT EXISTS Equipement (
        ID INT NOT NULL AUTO_INCREMENT,
        nom VARCHAR(50),
        mac VARCHAR(50),
        ip VARCHAR(19),
        cidr VARCHAR(3),
        idT INT,
        PRIMARY KEY (ID),
        FOREIGN KEY (idT) REFERENCES TypeE(ID)
    );
	REVOKE ALL PRIVILEGES ON MyGest.* FROM "%"@"%";
    GRANT ALL PRIVILEGES ON MyGest.TypeE TO root;
    GRANT ALL PRIVILEGES ON MyGest.Equipement TO root;
    FLUSH PRIVILEGES;
EOF
    echo "Base de données et tables créées avec succès."
#}

# Menu pour afficher la base de données
afficher_bdd() {
    while true; do
        clear
        echo "=== Menu ==="
        echo "1. Afficher Equipement"
        echo "2. Afficher TypeE"
        echo "3. Retour"
        echo -n "Choisissez une option: "
        read choix

        case $choix in
            1)
                echo "Affichage des équipements"
                mysql -u root -e "SELECT * FROM MyGest.Equipement;"
                ;;
            2)
                echo "Affichage des types de matériel"
                mysql -u root -e "SELECT * FROM MyGest.TypeE;"
                ;;
            3)
                break
                ;;
            *)
                echo "Option invalide."
                ;;
        esac
        read -p "Appuyez sur une touche pour continuer..."
    done
}

# Ajouter une machine
ajouter_machine() {
    while true; do
        clear
        echo "=== Ajouter une machine ==="
        echo "1. Ajouter un type de materiel TypeE)"
        echo "2. Ajouter une machine à l'équipement actif (Equipement)"
        echo "3. Retour"
        echo -n "Choisissez une option: "
        read choix

        case $choix in
            1)
                echo -n "Entrez le libelle du type de matériel: "
                read libelle
                mysql -u root -e "INSERT INTO MyGest.TypeE (libelle) VALUES ('$libelle');"
                echo "Type de matériel ajouté."
                ;;
            2)
                echo -n "Entrez le nom de la machine: "
                read nom
                echo -n "Entrez l'adresse MAC: "
                read mac
                echo -n "Entrez l'adresse IP: "
                read ip
                echo -n "Entrez le CIDR: "
                read cidr
                echo -n "Entrez l'ID du type de matériel (idT): "
                read idT

                # Vérification si idT existe
                count=$(mysql -u root -se "SELECT COUNT(*) FROM MyGest.TypeE WHERE ID=$idT;")
                if [ "$count" -eq 0 ]; then
                    echo "Erreur : L'ID du type de matériel n'existe pas."
                else
                    mysql -u root -e "INSERT INTO MyGest.Equipement (nom, mac, ip, cidr, idT) VALUES ('$nom', '$mac', '$ip', '$cidr', $idT);"
                    echo "Machine ajoutée à l'équipement actif."
                fi
                ;;
            3)
                break
                ;;
            *)
                echo "Option invalide."
                ;;
        esac
        read -p "Appuyez sur une touche pour continuer..."
    done
}

# Supprimer une machine
supprimer_machine() {
    while true; do
        clear
        echo "=== Supprimer une machine ==="
        echo "1. Supprimer un type de machine de l'entreprise (Equipement et TypeE)"
        echo "2. Supprimer une machine de l'équipement actif (Equipement)"
        echo "3. Retour"
        echo -n "Choisissez une option: "
        read choix

        case $choix in
            1)
                echo -n "Entrez l'ID du type de matériel à supprimer: "
                read idT
                mysql -u root -e "DELETE FROM MyGest.Equipement WHERE idT=$idT;"
                mysql -u root -e "DELETE FROM MyGest.TypeE WHERE ID=$idT;"
                echo "Machine supprimée de l'entreprise."
                ;;
            2)
                echo -n "Entrez l'ID de la machine à supprimer: "
                read id
                mysql -u root -e "DELETE FROM MyGest.Equipement WHERE ID=$id;"
                echo "Machine supprimée de l'équipement actif."
                ;;
            3)
                break
                ;;
            *)
                echo "Option invalide."
                ;;
        esac
        read -p "Appuyez sur une touche pour continuer..."
    done
}

# Modifier des données
modifier_donnees() {
    while true; do
        clear
        echo "=== Modifier les données ==="
        echo "1. Modifier les informations de l'équipement"
        echo "2. Modifier les informations du type de matériel"
        echo "3. Retour"
        echo -n "Choisissez une option: "
        read choix

        case $choix in
            1)
                echo -n "Entrez l'ID de l'équipement à modifier: "
                read id
                echo -n "Entrez le nouveau nom: "
                read nom
                echo -n "Entrez la nouvelle adresse MAC: "
                read mac
                echo -n "Entrez la nouvelle adresse IP: "
                read ip
                echo -n "Entrez le nouveau CIDR: "
                read cidr
                echo -n "Entrez le nouvel ID de type de matériel: "
                read idT
                mysql -u root -e "UPDATE MyGest.Equipement SET nom='$nom', mac='$mac', ip='$ip', cidr='$cidr', idT=$idT WHERE ID=$id;"
                echo "Équipement mis à jour."
                ;;
            2)
                echo -n "Entrez le nouveau libellé du type de matériel: "
                read libelle
                echo -n "Entrez l'ID du type de matériel à modifier: "
                read idT
                mysql -u root -e "UPDATE MyGest.TypeE SET libelle='$libelle' WHERE ID=$idT;"
                echo "Type de matériel mis à jour."
                ;;
            3)
                break
                ;;
            *)
                echo "Option invalide."
                ;;
        esac
        read -p "Appuyez sur une touche pour continuer..."
    done
}

# Menu principal
while true; do
    clear
    echo "=== Menu Principal ==="
    echo "1. Afficher la base de données"
    echo "2. Ajouter des données"
    echo "3. Supprimer des données"
    echo "4. Modifier des données"
    echo "5. Quitter"
    echo -n "Choisissez une option: "
    read option

    case $option in

        1)
            afficher_bdd
            ;;
        2)
            ajouter_machine
            ;;
        3)
            supprimer_machine
            ;;
        4)
            modifier_donnees
            ;;
        5)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Option invalide."
            ;;
    esac
    read -p "Appuyez sur une touche pour continuer..."
done
