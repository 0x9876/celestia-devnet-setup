#!/usr/bin/env bash

echo "Initializing app."
celestia-appd init "$MONIKER"
# Fetch devnet-2 genesis config
curl \
    --fail --silent --remote-name \
    --output-dir /home/appuser/.celestia-app/config/ \
    https://raw.githubusercontent.com/celestiaorg/networks/master/devnet-2/genesis.json
echo "Initialization finished."

echo "Creating default wallet:"
celestia-appd keys add default
