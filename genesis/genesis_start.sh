#!/bin/bash
DATADIR="./blockchain"

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi

nodeos \
--genesis-json "../genesis.json" \
--signature-provider EOS5scyDxxcyX58rs1ejkwAex5THLsj3GxkSrtWqXUGxAM6Q2d2yM=KEY:5J3CNYueS33xnX9yEspHjDG89WhWQRNfqRoo2b2cjSpyeK1CQyw \
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
--producer-name eosio \
--http-server-address 127.0.0.1:8888 \
--p2p-listen-endpoint 127.0.0.1:9010 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"
