#!/bin/bash

if [ -z "$NETWORK" ]
then
      NETWORK=local
fi
# echo On créé une copro 
dfx canister --network=$NETWORK call belisama createCopro '(record {address="40 rue du Colisée, 75008 Paris"})'
# echo On créé un énoncé de vote
dfx canister --network=$NETWORK call belisama createPoll '(record {description="Etes-vous d''accord pour que nous hébergions un hackathon dans les locaux ?"})'
# echo On rattache une proposition à l énoncé de vote 'Oui'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="Oui"; pollId=1})'
# echo On rattache une proposition à l énoncé de vote 'Non'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="Non"; pollId=1})'
# echo On créé un énoncé de vote
dfx canister --network=$NETWORK call belisama createPoll '(record {description="Etes-vous d''accord pour que nous changions la peinture dans les locaux ?"})'
# echo On rattache une proposition à l énoncé de vote 'Oui'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="Oui"; pollId=2})'
# echo On rattache une proposition à l énoncé de vote 'Non'
dfx canister --network=$NETWORK call belisama addProposal '(record {description="Non"; pollId=2})'
# echo On vote Oui 
dfx canister --network=$NETWORK call belisama vote '(1)'


dfx canister --network=$NETWORK call belisama createCopro '(record {address="30 rue du Colisée, 75008 Paris"})'
dfx canister --network=$NETWORK call belisama createCopro '(record {address="15 rue de la belle blanche, 94600 choisy-le-roi"})'
dfx canister --network=$NETWORK call belisama createCopro '(record {address="105 rue de garosh, 77120 coulommiers"})'

