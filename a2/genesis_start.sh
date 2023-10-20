#!/bin/bash
DATADIR="./blockchain"

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi

nodeos \
--genesis-json "../genesis.json" \
--signature-provider EOS5effqCyFit92RxGRpoyRg2aQfj67P1gNBzzT8HpoZ46pj6FC9T=KEY:5K9oHuJBSx1c8Y8gaU3GMPyjkHdjAGhUFFsDAQ5eKcJfz8avpE2 \
--plugin eosio::net_api_plugin \
--plugin eosio::net_plugin \
--plugin eosio::producer_plugin \
--plugin eosio::producer_api_plugin \
--plugin eosio::chain_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::history_api_plugin \
--plugin eosio::history_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--producer-name a2 \
--http-server-address 127.0.0.1:8012 \
--p2p-listen-endpoint 127.0.0.1:9012 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--p2p-peer-address localhost:9011 \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"
