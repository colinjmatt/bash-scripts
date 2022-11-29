#!/bin/bash
clear
while :; do
cat<<EOF

1) Install Steam

2) Install Starbound

3) Install Project Zomboid

4) Install Minecraft

q) Quit

EOF
    read -n1 -s -r
    case "$REPLY" in
    	"1")
			if [[ ! -d ~/steam ]]; then 
				echo "Installing Steam..."
				mkdir ~/steam
				cd ~/steam || exit
				wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
				tar -xvzf steamcmd_linux.tar.gz
				sudo apt-get -y -t stable install lib32gcc1
				clear
			else echo "Steam already installed..."
				sleep 1
				clear
			fi ;;

		"2")
			if [[ ! -d ~/starbound ]]; then
				echo "Installing Starbound..."
				./steamcmd.sh +login m1n1m3c0l1n +force_install_dir ~/starbound/server +app_update 211820 +exit
				clear
			else echo "Starbound already installed..."
				sleep 1
				clear
			fi ;;

		"3")
			if [[ ! -d ~/Zomboid/zomboid ]]; then
				echo "Installing Project Zomboid..."
				./steamcmd.sh +login m1n1m3c0l1n +force_install_dir ~/Zomboid/zomboid/server +app_update 380870 +exit
				clear
			else echo "Project Zomboid already installed..."
				sleep 1
				clear
			fi ;;

		"4")
            if [[ -z $version ]]; then
                echo -n "Please enter the version of Minecraft you wish to install: "
                read -r version < /dev/tty
                clear
            fi
			if [[ ! -d ~/minecraft/$version ]]; then
				echo "Installing Minecraft $version..."
				apt-get -t testing install openjdk-8-jdk-headless
				mkdir -p ~/minecraft/"$version"
				cd ~/minecraft/ || exit
				wget https://s3.amazonaws.com/Minecraft.Download/versions/"$version"/minecraft_server."$version".jar -P ~/minecraft/"$version"/
				echo "#!/bin/bash" > ~/minecraft/minecraft_serverstart.sh
				echo "java -Xmx1024M -Xms1024M -jar ~/minecraft/$version/minecraft_server.$version.jar nogui" >> ~/minecraft/minecraft_serverstart.sh
				chmod +x ~/minecraft/minecraft_serverstart.sh
				echo "eula=true" > ~/minecraft/eula.txt
				clear
			else echo "Minecraft $version is already installed..."
				sleep 1
				clear
			fi ;;

		"q")
			exit 0 ;;

        "*")
		    echo "Invalid option, please try again."
		    sleep 1 ;;
	esac
done