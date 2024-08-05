#!/bin/bash

id=0
idFile=./id.txt
if [ -e "$idFile" ]; then
	id=$(cat ./id.txt)
else
	echo "ID file doesn't exist."
	exit 1
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

cd $HOME/.steam/steam/steamapps/common/GarrysMod/bin

LD_LIBRARY_PATH=./ ./gmad_linux create -folder $DIR -out ./addon.gma -warninvalid
LD_LIBRARY_PATH=./ ./gmpublish_linux update update -id $id -addon ./addon.gma
rm ./parts.gma
