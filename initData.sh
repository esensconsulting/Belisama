#!/bin/bash
dfx canister call belisama createCopro '(record {address="40 rue du Colisée, 75008 Paris"})'
dfx canister call belisama createPoll '(record {description="Etes-vous d''accord pour que nous hébergions un hackathon dans les locaux ?"})'
dfx canister call belisama addProposal '(record {description="Oui"; pollId=1})'
dfx canister call belisama addProposal '(record {description="Non"; pollId=1})'