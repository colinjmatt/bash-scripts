#!/bin/bash
wpa_cli scan
wpa_cli scanresults
SSID="$1"
echo ""
echo -n "Please choose a wireless network from the above list: "
read -r SSID < /dev/tty
clear
PSK="$1"
echo -n "Please enter the password for ""$SSID"": "
read -r SSID < /dev/tty

while :; do
    clear

cat<<EOF
Your wireless network is called "$SSID"
The password you entered starts with "${PSK: +2}" and ends with "${PSK: -2}"


Is the above information correct? (y/n)

EOF

    read -n1 -s -r
    case "$REPLY" in
        "y")
            wpa_cli add_network
            wpa_cli set_network 0 ssid "$SSID"
            wpa_cli set_network 0 psk "$PSK"
            wpa_cli enable_network 0
            wpa_cli save config
            wpa_cli dhcpd interface
            echo "Connecting to wireless network, please wait."
            sleep 10
            if
                ping -c 1 google.com &> /dev/null; then
                clear
                echo "Wireless setup successful!"
                sleep 2
                break
            else
                clear
                echo "Wireless setup unsuccessful, please try again."
                wpa_cli remove_network 0
                continue
            fi;;
        "n")
            clear
            echo "Please enter the wireless information again"
            sleep 2
            continue;;
        *)
            echo "Invalid option, please try again."
            sleep 2;;
    esac
done
