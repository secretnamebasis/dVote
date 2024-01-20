> [!IMPORTANT]
> See subdirectory `cli` for examples how to use dVote CLI<br>

> [!IMPORTANT]
> This php script is developed just as much as required to perform the task.<br>

# Semi-automated smart contract tests
### A php script to record two smart contract states and calculate the diff.

This php script requires:<br>
PHP 8.x<br>
<br>


## Execute all smart contract function tests

`php executeTests.php`<br>

## Execute specific smart contract function tests

`php executeTests.php <SC function name>`<br>
`php executeTests.php Vote`<br>
`php executeTests.php TallyVotes`<br>
`php executeTests.php UpdateVotingFee`<br>


### Explanation
The php script detects the provided smart contract function tests automatically in `tests/*`.
It executes each test and creates a `before.json`, `after.json`, and `diff.json` file in each test case directory.
The script tries to detect hex encoded strings and unix timestamps in the `diff.json` file and converts them into human readable formats.
Reviewing the files `before.json`, `after.json`, and `diff.json` and verifying the results needs to be done manually.