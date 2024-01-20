#!/bin/bash
TEST_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TEST_DIR")")")"

$BASEDIR/cli/getScStatus.sh $TEST_DIR/before.json

$BASEDIR/cli/invoke_wallet1.sh UpdateVotingEnd 0 0 4 $(($(date +%s) + 300))
sleep 1
$BASEDIR/cli/getScStatus.sh $TEST_DIR/after.json