#!/bin/bash
# echo On créé une copro 
dfx canister call belisama createCopro '(record {address="40 rue du Colisée, 75008 Paris"})'
# echo On créé un énoncé de vote
dfx canister call belisama createPoll '(record {description="Etes-vous d''accord pour que nous hébergions un hackathon dans les locaux ?"})'
# echo On rattache une proposition à l énoncé de vote 'Oui'
dfx canister call belisama addProposal '(record {description="Oui"; pollId=1})'
# echo On rattache une proposition à l énoncé de vote 'Non'
dfx canister call belisama addProposal '(record {description="Non"; pollId=1})'
# echo On récupère les proposition de l enoncé de vote 
dfx canister call belisama getProposalsByPollId '(1)'
# echo On vote Oui 
dfx canister call belisama vote '(1)'

