#!/bin/bash
DATADIR="./blockchain"

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi

nodeos \
--genesis-json "../genesis.json" \
--signature-provider EOS5GYr1ysNHjoaDsKnGFHWzx3YSS5jNFTrtr4cECnNgyVJfkkAYe=KEY:5JzwNh4wYWbA9c7xDugpJfvCjnVCxjYbRzA6NSS8vMc1D6MWPBt \
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
--producer-name a1 \
--http-server-address 127.0.0.1:8011 \
--p2p-listen-endpoint 127.0.0.1:9011 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--p2p-peer-address localhost:9010 \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"
