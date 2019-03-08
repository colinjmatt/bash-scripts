#!/bin/bash
# Install Starbound dedicated server on Arch Linux
yay -S steamcmd

echo "steamcmd +login m1n1m3c0l1n +force_install_dir /home/colin/starbound/server +app_update 211820 +exit" > /home/colin/update_starbound.sh

chown colin:colin /home/colin/update_starbound.sh
chmod 0700 /home/colin/update_starbound.sh

steamcmd +login m1n1m3c0l1n +force_install_dir /home/colin/starbound/server +app_update 211820 +exit

echo "You now need to make sure TCP port 21025 is forwarded"
echo ""
echo "In \"/home/colin/starbound/server/linux/\", run \"./starbound_server to begin!\""
