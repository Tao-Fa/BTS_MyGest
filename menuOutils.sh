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
