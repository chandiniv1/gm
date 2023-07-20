#!/bin/sh

VALIDATOR_NAME=validator1
CHAIN_ID=gm
KEY_NAME=gm-key
CHAINFLAG="--chain-id ${CHAIN_ID}"
TOKEN_AMOUNT="10000000000000000000000000stake"
STAKING_AMOUNT="1000000000stake"

NAMESPACE_ID=$(openssl rand -hex 8)
echo $NAMESPACE_ID
DA_BLOCK_HEIGHT=$(curl https://rpc-blockspacerace.pops.one/block | jq -r '.result.block.header.height')
echo $DA_BLOCK_HEIGHT

ignite chain build
gmd tendermint unsafe-reset-all
gmd init $VALIDATOR_NAME --chain-id $CHAIN_ID

gmd keys add $KEY_NAME --keyring-backend test
gmd add-genesis-account $KEY_NAME $TOKEN_AMOUNT --keyring-backend test
gmd gentx $KEY_NAME $STAKING_AMOUNT --chain-id $CHAIN_ID --keyring-backend test
gmd collect-gentxs
#gmd start --rollkit.aggregator true --rollkit.da_layer celestia --rollkit.da_config='{"base_url":"http://localhost:26659","timeout":60000000000,"fee":6000,"gas_limit":6000000}' --rollkit.namespace_id $NAMESPACE_ID --rollkit.da_start_height $DA_BLOCK_HEIGHT
gmd start --rollkit.aggregator true --rollkit.da_layer avail --rollkit.da_config='{ "seed":"bottom drive obey lake curtain smoke basket hold race lonely fit walk//Alice","api_url":"ws://127.0.0.1:9944","size":1000,"app_id" : 0, "dest" : "5H3qehpRTFiB3XwyTzYU43SpG7e8jW87vFug95fxdew76Vyi","amount" : 10}' --rollkit.namespace_id $NAMESPACE_ID --rollkit.da_start_height 149448 --api.enable --api.enabled-unsafe-cors
