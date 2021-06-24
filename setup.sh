#!/usr/bin/env bash

# mount volume in Linode - if you used a different name, change esplora to the name you used
sudo mkfs.ext4 "/dev/disk/by-id/scsi-0Linode_Volume_esplora_volume"
sudo mkdir "/mnt/esplora_volume"
sudo mount "/dev/disk/by-id/scsi-0Linode_Volume_esplora_volume" "/mnt/esplora_volume"

#ensure mount on boot
echo "/dev/disk/by-id/scsi-0Linode_Volume_esplora_volume /mnt/esplora_volume ext4 defaults,noatime,nofail 0 2" | sudo tee -a /etc/fstab

#update apt and install docker
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# install git, clone into esplora repo
sudo apt-get install -y git
cd /mnt/esplora_volume
git clone https://github.com/Blockstream/esplora.git
cd esplora

# build docker image
sudo docker build -t esplora .

# install screen and run mainnet container in screen
sudo apt-get install -y screen
echo "sudo docker run -e DEBUG=verbose -e NO_PRECACHE=1 -e NO_ADDRESS_SEARCH=1 -e ENABLE_LIGHTMODE=1 -p 50001:50001 -p 8080:80 --volume $PWD/data_bitcoin_mainnet:/data --rm -i -t esplora bash -c \"/srv/explorer/run.sh bitcoin-mainnet explorer\"" | sudo tee /mnt/esplora_volume/esplora/mainnet.sh
sudo chmod +x /mnt/esplora_volume/esplora/mainnet.sh
sudo screen -dmS mainnet /mnt/esplora_volume/esplora/mainnet.sh

