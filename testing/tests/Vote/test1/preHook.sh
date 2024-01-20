#!/bin/bash
TEST_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TEST_DIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/tests/init_default.sh
sleep 1
$BASEDIR/cli/invoke_wallet1.sh UpdateVotingStart 0 0 2 $(($(date +%s) + 10))
sleep 1
$BASEDIR/cli/invoke_wallet1.sh UpdateVotingEnd 0 0 2 $(($(date +%s) + 40))
sleep 1
$BASEDIR/cli/invoke_wallet1.sh UpdateVotesMax 0 0 2 500

