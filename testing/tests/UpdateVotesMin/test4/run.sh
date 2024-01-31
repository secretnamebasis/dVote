#!/bin/bash
TEST_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TEST_DIR")")")"

$BASEDIR/cli/getScStatus.sh $TEST_DIR/before.json

# NO
$BASEDIR/cli/invoke_wallet1.sh UpdateVotesMin 0 0 4 16 0
sleep 1

# YES
$BASEDIR/cli/invoke_wallet1.sh UpdateVotesMin 0 0 4 16 1
sleep 1

# TOTAL
$BASEDIR/cli/invoke_wallet1.sh UpdateVotesMin 0 0 4 20 2
sleep 1
$BASEDIR/cli/getScStatus.sh $TEST_DIR/after.json