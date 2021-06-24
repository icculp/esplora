#!/usr/bin/env bash

echo "sudo docker run -e DEBUG=verbose -e NO_PRECACHE=1 -e NO_ADDRESS_SEARCH=1 -e ENABLE_LIGHTMODE=1 -p 50001:50001 -p 8080:80 --volume $PWD/data_bitcoin_mainnet:/data --rm -i -t esplora bash -c \"/srv/explorer/run.sh bitcoin-mainnet explorer\"" | sudo tee mainnet.sh
sudo chmod +x mainnet.sh
echo "screen -dmS mainnet /mnt/fullnode/esplora2/mainnet.sh" | sudo tee test.conf
screen -d -c test.conf

