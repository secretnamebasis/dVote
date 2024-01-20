#!/bin/bash
TEST_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TEST_DIR")")")"

$BASEDIR/cli/invoke_wallet1.sh UpdateVotingEnd 0 0 2 $(($(date +%s) + 3600))