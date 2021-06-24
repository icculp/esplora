#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo apt-get install -y git
git clone https://github.com/Blockstream/esplora.git
cd esplora
sudo docker build -t esplora .

sudo apt-get install -y screen
screen -SR mainnet
sudo docker run -e DEBUG=verbose -e NO_PRECACHE=1 -e NO_ADDRESS_SEARCH=1 -e ENABLE_LIGHTMODE=1 -p 50001:50001 -p 8080:80 --volume $PWD/data_bitcoin_mainnet:/data --rm -i -t esplora bash -c "/srv/explorer/run.sh bitcoin-mainnet explorer"
