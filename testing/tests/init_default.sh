#!/bin/bash

# # Voting opens 10 seconds from now
# cli/invoke_wallet1.sh UpdateVotingStart 0 0 2 $(($(date +%s) + 10))
# sleep 1
# # Voting ends 3600 seconds from now , eg 60 minutes
# cli/invoke_wallet1.sh UpdateVotingEnd 0 0 2 $(($(date +%s) + 3600))
# sleep 1
# # Every vote (token) costs 100 deri to place
# cli/invoke_wallet1.sh UpdateVotingFee 0 0 2 100
# sleep 1
# # Publish voter's account addresses, vote count, answer and voting timestamp
# cli/invoke_wallet1.sh UpdateDisplayVoters 0 0 2 1
# sleep 1
# # Deny all anonymous votes
# cli/invoke_wallet1.sh UpdateRejectAnonymousVote 0 0 2 0
# sleep 1
# # Mint maximum amount of ballots (tokens)
# cli/invoke_wallet1.sh UpdateVotesMax 0 0 2 25
# sleep 1
# # Vote with 100 DERI , 1 token, 2 rings, and yes=1
cli/invoke_wallet1.sh Vote 100 1 2 1
# # TallyVote 0 deri 0 token 2 rings
# cli/invoke_wallet1.sh TallyVotes 0 0 2
