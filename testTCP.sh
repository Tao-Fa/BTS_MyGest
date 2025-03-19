#!/bin/bash

# Demander à l'utilisateur l'adresse IP de la machine cible
echo "Entrez l'adresse IP de la cible : "
read ip_address

# Demander à l'utilisateur le numéro du port à tester
echo "Entrez le numéro du port à tester : "
read port_number

# Utilisation de nmap pour tester si le port est ouvert
echo "Vérification de l'état du port $port_number sur l'adresse $ip_address..."
nmap -p $port_number $ip_address
