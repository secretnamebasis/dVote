#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

ADDRESSES_FILE=wallet_addresses.dat
BAS_FILE=logo_dVote.bas
export IP="127.0.0.1"
export PORT="30000"
ENDPOINT="http://$IP:$PORT"
METHOD="install_sc"

# Default parameters
DEFAULT_RINGSIZE=2
DEFAULT_DERI_AMOUNT=0
DEFAULT_TOKEN_AMOUNT=0
DEFAULT_TRUE_AMOUNT=1
DEFAULT_FALSE_AMOUNT=0
VOTE_TOKEN_MAX=21
VOTE_DERI_COST=100
VOTE_TOKEN_ONE=1
VOTE_NO=0 
VOTE_YES=1
VOTE_ABSTAIN=2 # VOTING NOT TO VOTE 

pause() {
sleep 3
}

curl -s \
    --request POST \
    --data-binary @$BAS_FILE $ENDPOINT/$METHOD \
    | grep -oE "[0-9a-f]{64}" \
    | sed 's/^/SCID=/' > scid.dat

# # Source the SCID from the file
pause # wait for the contract to settle

source scid.dat

# Function to invoke the wallet script with error handling
invoke_wallet() {
    echo "$@"
    if ! cli/invoke_wallet.sh "$@" ; then
        echo "Error invoking wallet script: $@"
        exit 1
    fi
    pause # wait for each contract call to settle
}

# Update voting start time
invoke_wallet \
    UpdateVotingStart \
    $DEFAULT_DERI_AMOUNT \
    $DEFAULT_TOKEN_AMOUNT \
    $DEFAULT_RINGSIZE \
    $(($(date +%s) + 60)) #VOTE_START

# Update voting end time
invoke_wallet \
    UpdateVotingEnd \
    $DEFAULT_DERI_AMOUNT \
    $DEFAULT_TOKEN_AMOUNT \
    $DEFAULT_RINGSIZE \
    $(($(date +%s) + 3600)) #VOTE_END

# Update voting fee
invoke_wallet \
    UpdateVotingFee \
    $DEFAULT_DERI_AMOUNT \
    $DEFAULT_TOKEN_AMOUNT \
    $DEFAULT_RINGSIZE \
    $DEFAULT_DERI_AMOUNT

# Update display voters
invoke_wallet \
    UpdateDisplayVoters \
    $DEFAULT_DERI_AMOUNT \
    $DEFAULT_TOKEN_AMOUNT \
    $DEFAULT_RINGSIZE \
    $DEFAULT_FALSE_AMOUNT 

# Update reject anonymous votes
invoke_wallet \
    UpdateRejectAnonymousVote \
    $DEFAULT_DERI_AMOUNT \
    $DEFAULT_TOKEN_AMOUNT \
    $DEFAULT_RINGSIZE \
    $DEFAULT_FALSE_AMOUNT

# Update votes max
invoke_wallet \
    UpdateVotesMax \
    $DEFAULT_DERI_AMOUNT \
    $DEFAULT_TOKEN_AMOUNT \
    $DEFAULT_RINGSIZE \
    $VOTE_TOKEN_MAX

# T R A N S F E R
touch "$ADDRESSES_FILE"
echo "" > "$ADDRESSES_FILE"

# Build a list of WALLETADDRESS data
for ((i=0; i<=21; i++)); do
    echo "WALLETADDRESS$i=$(
        curl -s \
        -X POST http://$IP:$((30000 + i))/json_rpc \
        -H 'content-type: application/json' \
        -d '{
             "jsonrpc": "2.0",
             "id": "0",
             "method": "GetAddress"
            }' \
            | jq -r '.result.address'
        )" >> "$ADDRESSES_FILE"
done
pause

# Function to construct transfer object for a wallet address
construct_transfer() {
    local address="$1"
    local transfer='{
        "scid": "'"$SCID"'",
        "destination": "'"$address"'",
        "amount": 1
    }'
    echo "$transfer"
}

# Function to construct transfer object for a wallet address
construct_transfer() {
    local address="$1"
    local transfer='{
        "scid": "'"$SCID"'",
        "destination": "'"$address"'",
        "amount": 1
    }'
    echo "$transfer"
}

# Construct transfers array
transfers="["
# Loop to send to wallets in batches of 6 until all addresses are processed
for ((start = 1; start <= 21; start += 6)); do
    end=$((start + 5))
    # Transfer to wallets in the current batch
    for ((i = start; i <= end && i <= 21; i++)); do
        addressVar="WALLETADDRESS$i"
        address="${!addressVar}"
        transfer=$(construct_transfer "$address")
        transfers+="$(printf '%s' "$transfer"),"
    done
    # Remove the trailing comma
    transfers="${transfers%,}"
    transfers+="]"

    # Send the bulk transfer request
    curl -X POST \
      $ENDPOINT/json_rpc \
      -H 'content-type: application/json' \
      -d '{
        "jsonrpc": "2.0",
        "id": "1",
        "method": "transfer",
        "params": {
            "transfers": '"$transfers"',
            "ringsize": 8
        }
    }'

    # Reset transfers array for the next batch
    transfers="["
done

# check balance ; should be 0
source ./cli/getSCIDBalance_wallet0.sh

# Vote with 100 DERI, 1 token, 2 rings, and yes=1
invoke_wallet \
    Vote \
    $DEFAULT_DERI_AMOUNT \
    $VOTE_TOKEN_ONE \
    $DEFAULT_RINGSIZE \
    $VOTE_YES



