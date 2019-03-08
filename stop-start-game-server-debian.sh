#!/bin/bash
clear
while :; do
cat<<EOF

Restart or stop:

1) Starbound...

2) Project Zomboid...

3) Minecraft...

q) Quit

EOF
    read -n1 -s -r
    case "$REPLY" in
    	"1")
			clear
            echo -n "Press \"r\" to update and restart Starbound server, or \"s\" to stop it"
            read -n1 -s -r
		    case "$REPLY" in
		    	"r")
					screen -S Starbound -X stuff ^C
					screen -X -S Starbound quit
					~/steam/steamcmd.sh +login m1n1m3c0l1n +force_install_dir ~/starbound/server +app_update 211820 +exit
					screen -d -m -S Starbound
					screen -S Starbound -X stuff 'cd ~/starbound/server/linux'`echo -ne '\015'`
					screen -S Starbound -X stuff './starbound_server'`echo -ne '\015'`
					clear ;;

				"s")
					screen -S Starbound -X stuff ^C
					screen -X -S Starbound quit
					clear ;;

				"*")
		            echo "Invalid option, please try again."
		            sleep 1 
		            clear
		    esac ;;

		"2")
			clear
            echo -n "Press \"r\" to update and restart Project Zomboid server, or \"s\" to stop it"
            read -n1 -s -r
		    case "$REPLY" in
		    	"r")
					screen -S Zomboid -X stuff 'quit'
					screen -X -S Zomboid quit
					~/steam/steamcmd.sh +login m1n1m3c0l1n +force_install_dir ~~/Zomboid/zomboid/server +app_update 211820 +exit
					screen -d -m -S Zomboid
					screen -S Zomboid -X stuff 'cd ~/Zomboid/zomboid/server'`echo -ne '\015'`
					screen -S Zomboid -X stuff './start_server.sh'`echo -ne '\015'`
					clear ;;

				"s")
					screen -S Zomboid -X stuff 'quit'
					screen -X -S Zomboid quit
					clear ;;

				"*")
		            echo "Invalid option, please try again."
		            sleep 1 
		            clear
		        esac ;;

		"3")
			clear
            echo -n "Press \"r\" to restart Minecraft server, or \"s\" to stop it"
            read -n1 -s -r
		    case "$REPLY" in
		    	"r")
					screen -S Minecraft -X stuff 'stop'
					screen -X -S Minecraft quit
					screen -d -m -S Minecraft
					screen -S Minecraft -X stuff 'cd ~/minecraft/'`echo -ne '\015'`
					screen -S Minecraft -X stuff './minecraft_serverstart.sh'`echo -ne '\015'`
					clear ;;

				"s")
					screen -S Minecraft -X stuff 'stop'
					screen -X -S Minecraft quit
					clear ;;

				"*")
		            echo "Invalid option, please try again."
		            sleep 1 
		            clear
		        esac ;;

        "*")
		    echo "Invalid option, please try again."
		    sleep 1 ;;
	esac
done


