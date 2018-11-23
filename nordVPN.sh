#!/bin/bash

file_param="$HOME/.config/nordVPN/list_serv.txt"
app_openvpn=$(command -v openvpn)

# vérification de l'installation d'openvpn
verif=0
if [ $app_openvpn ]
  then
  verif=1
fi


if [ $verif = 0 ]
  then
  zenity --error \
  --width=300 \
  --text="Veuillez installer openvpn :

Exemples :
apt install openvpn (Debian/Ubuntu)
dnf install openvpn (Red Hat/Fedora)
pamac install openvpn (Manjaro gnome)
pacman -S openvpn (Arch)
zypper in openvpn (SLES/openSUSE)
emerge -v net-vpn/openvpn (Gentoo)"
   exit
fi
# fin de vérification

# initialisation du fichier de paramètrage
if test -e $file_param ; then 
	if [[ $(cat $file_param) = "init" ]]; then
		ls /etc/openvpn/ovpn_tcp/ > $file_param
		ls /etc/openvpn/ovpn_udp/ >> $file_param
	fi
	echo "ok"
else 
	zenity --error \
  --width=400 \
  --text="Veuillez créer le fichier :
$file_param"
  exit
fi
# lecture du fichier de choix
n=0
while read line
do
dir_openvpn[$n]=$(echo $line)
n=$((n=$n + 1))
done < $file_param

# affichage du fichier de choix
choix=$(zenity --list \
  --width=700 \
  --height=250 \
  --title="Choisissez la connection (retirer ou ajouter vos choix dans $file_param)" \
  --column="connection" \
${dir_openvpn[@]})


test_prot=$(echo $choix | cut -d'.' -f4)


if [[ $test_prot = "udp" ]]; then
	terminator -x sudo openvpn /etc/openvpn/ovpn_udp/$choix	
else 
	terminator -x sudo openvpn /etc/openvpn/ovpn_tcp/$choix	
fi
