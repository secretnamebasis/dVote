#!/bin/bash
TEST_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TEST_DIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/cli/invoke_wallet1.sh UpdateVotingFee 1000 0 2 1000
sleep 1
$BASEDIR/cli/invoke_wallet1.sh UpdateVotesMax 0 0 2 25
sleep 1
$BASEDIR/cli/invoke_wallet1.sh Vote 1000 1 2 1

