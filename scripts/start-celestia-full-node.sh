#!/usr/bin/env bash

CELESTIA_FULL="celestia full --core.remote $CELESTIA_CORE_REMOTE"

echo "Initializing node..."
TRUSTED_HASH="$(curl -s http://celestia_app_start:26657/block?height=1 | jq -r '.result.block_id.hash')"
$CELESTIA_FULL init --headers.trusted-hash "$TRUSTED_HASH"
echo "Initialization finished."

echo "Starting node..."
$CELESTIA_FULL start
