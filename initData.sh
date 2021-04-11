#!/bin/bash

if [ -z "$NETWORK" ]
then
      NETWORK=local
fi
# echo On créé une copro 
dfx canister --network=$NETWORK call belisama createCopro '(record {address="40 rue du Colisée, 75008 Paris"})'
# echo On créé un énoncé de vote
dfx canister --network=$NETWORK call belisama createPoll '(record {description="Do you agree that we host a hackathon on company premises?"})'
# echo On rattache une proposition à l énoncé de vote 'Oui'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="Yes"; pollId=1})'
# echo On rattache une proposition à l énoncé de vote 'Non'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="No"; pollId=1})'
# echo On créé un énoncé de vote
dfx canister --network=$NETWORK call belisama createPoll '(record {description="Do you agree that we change the paint in the hallways of the residence?"})'
# echo On rattache une proposition à l énoncé de vote 'Oui'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="Yes"; pollId=2})'
# echo On rattache une proposition à l énoncé de vote 'Non'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="No"; pollId=2})'
# echo On vote Oui 
dfx canister --network=$NETWORK call belisama vote '(1)'


dfx canister --network=$NETWORK call belisama createCopro '(record {address="30 rue du Colisée, 75008 Paris"})'
dfx canister --network=$NETWORK call belisama createCopro '(record {address="15 rue de la belle blanche, 94600 choisy-le-roi"})'
dfx canister --network=$NETWORK call belisama createCopro '(record {address="105 rue de garosh, 77120 coulommiers"})'

