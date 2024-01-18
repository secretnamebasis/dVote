# dVote CLI
### A command line wrapper to interact with smart contracts

This bash wrapper requires these tools / commands to invoke all smart contract functions correctly:<br>
grep<br>
sed<br>
curl<br>
jq<br>

The wrapper expects **simulator wallet** rpc accessible at `127.0.0.1:20201` (wallet1), `127.0.0.1:20202` (wallet2), `127.0.0.1:20203` (wallet3), etc and without authentication.<br>
The script `getScStatus.sh` expects a **simulator daemon rpc** accessible at `127.0.0.1:20000` without authentication.

## Setup

`./installsc_wallet1.sh`<br>
`./init_wallet1.sh`

## Invoking smart contract functions

### Example: Vote NO (0)
`cli/invoke_wallet1.sh Vote 0 1 2 0`

### Example: Vote YES (1)
`cli/invoke_wallet1.sh Vote 0 1 2 1`

### Example: ABSTAIN vote (2)
`cli/invoke_wallet1.sh Vote 0 1 2 2`

> [!IMPORTANT]
> See `init_wallet1.sh` for more examples<br>

### Explanation
`cli/invoke_wallet1.sh` executes the wrapper<br>
`Vote` is the names of the public smart contract functions to invoke.<br>
`0 1 2 0` defines how many DERI (0) and tokens (1) to send in the transaction, as well as the ring size (2) and the voting choice (0 = NO).<br>