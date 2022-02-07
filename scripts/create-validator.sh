#!/usr/bin/env bash

if [ $# -gt 1 ]; then
    echo -e "Usage:\n\t$0 [WALLET_NAME]"
    exit 1
fi

WALLET="${1:-default}"

PUBKEY="$(celestia-appd tendermint show-validator)"

echo "Creating validator using:"
echo -e "\tMoniker: $MONIKER"
echo -e "\tWallet: $WALLET"

celestia-appd tx staking create-validator \
 --amount=1000000celes \
 --pubkey="$PUBKEY" \
 --moniker="$MONIKER" \
 --commission-rate=0.1 \
 --commission-max-rate=0.2 \
 --commission-max-change-rate=0.01 \
 --min-self-delegation=1000000 \
 --from="$WALLET"
