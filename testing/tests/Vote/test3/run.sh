#!/bin/bash
TEST_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TEST_DIR")")")"

$BASEDIR/cli/getScStatus.sh $TEST_DIR/before.json

$BASEDIR/cli/invoke_wallet1.sh Vote 100 0 2 0
sleep 1
$BASEDIR/cli/invoke_wallet1.sh Vote 0 0 2 1
sleep 1
$BASEDIR/cli/invoke_wallet1.sh Vote 0 0 2 2
sleep 1
$BASEDIR/cli/getScStatus.sh $TEST_DIR/after.json