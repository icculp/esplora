sudo docker run -e DEBUG=verbose -e NO_PRECACHE=1 -e NO_ADDRESS_SEARCH=1 -e ENABLE_LIGHTMODE=1 -p 50001:50001 -p 8080:80 --volume /mnt/fullnode/esplora2/data_bitcoin_mainnet:/data --rm -i -t esplora bash -c "/srv/explorer/run.sh bitcoin-mainnet explorer"
