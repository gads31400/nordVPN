.DEFAULT_GOAL= help

install: nordVPN.sh nordVPN.png nordVPN.desktop list_serv.txt  ## Copie les fichiers nordVPN.sh nordVPN.png nordVPN.desktop list_serv.txt
	cp -f ./nordVPN.sh /usr/bin/nordVPN.sh
	chmod +x /usr/bin/nordVPN.sh
	cp -f ./nordVPN.png /usr/share/pixmaps/nordVPN.png
	cp -f ./nordVPN.desktop /usr/share/applications/nordVPN.desktop
	mkdir ~/.config/nordVPN
	cp -f ./list_serv.txt ~/.config/nordVPN/list_serv.txt



uninstall:  ## supprime les fichiers nordVPN.sh nordVPN.png nordVPN.desktop list_serv.txt
	rm /usr/bin/nordVPN.sh
	rm /usr/share/pixmaps/nordVPN.png
	rm /usr/share/applications/nordVPN.desktop
	rm ~/.config/nordVPN/list_serv.txt
help: 
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-10s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
