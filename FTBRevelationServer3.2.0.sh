#!/bin/bash
ram="6144" # Amount of RAM to give the server in MB

if ! [[ -e /usr/bin/java ]]; then
  sudo apt-get install openjdk-8-jre-headless
fi

if ! [[ -d ~/FTBRevelationServer ]]; then

  ( cd /tmp || exit
  wget https://media.forgecdn.net/files/2778/975/FTBRevelationServer_3.2.0.zip
  unzip -qq FTBRevelationServer_3.2.0.zip -d ~/FTBRevelationServer
  )

  ( cd ~/FTBRevelationServer || exit
  chmod +x FTBInstall.sh ServerStart.sh settings.sh
  ./FTBInstall.sh

  cat<<EOT > ./settings-local.sh
export JAVACMD="java"
export MAX_RAM="ramM"       # -Xmx
export JAVA_PARAMETERS="-XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=5 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10"
EOT

  echo eula=true > ./eula.txt
  sed -i -e "s/\"ramM\"/\""$ram"M\"/g" ./settings-local.sh

  )
fi

( cd ~/FTBRevelationServer || exit
./ServerStart.sh
)
