import Array "mo:base/Array";
import AssocList "mo:base/AssocList";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Time "mo:base/Time";
import CoproModule "./copro";
import PollModule "./poll";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import TrieSet "mo:base/TrieSet";
import Bool "mo:base/Bool";

actor Belisama {
    public type CoproId = CoproModule.CoproId;
    public type Copro = CoproModule.Copro;
    public type CreateCoproDto = CoproModule.CreateCoproDto;

    public type PollId = PollModule.PollId;
    public type ProposalId = PollModule.ProposalId;
    public type Poll = PollModule.Poll;
    public type Proposal = PollModule.Proposal;
    public type CreatePollDto = PollModule.CreatePollDto;
    public type CreateProposalDto = PollModule.CreateProposalDto;
    
    object coproCounter {
        var count = 0;
        public func inc() { count += 1 };
        public func read() : Nat { count };
        public func bump() : Nat {
            inc();
            read()
        };
    };
    object pollCounter {
        var count = 0;
        public func inc() { count += 1 };
        public func read() : Nat { count };
        public func bump() : Nat {
            inc();
            read()
        };
    };
    object proposalCounter {
        var count = 0;
        public func inc() { count += 1 };
        public func read() : Nat { count };
        public func bump() : Nat {
            inc();
            read()
        };
    };

    let copros = HashMap.HashMap<CoproId, Copro>(1, CoproModule.isEq, Hash.hash);
    let coprosMembership = HashMap.HashMap<Principal, Copro>(1, CoproModule.isEqPrincipal, Principal.hash);

    let polls = HashMap.HashMap<PollId, Poll>(1, PollModule.isEq, Hash.hash);
    let pollsByCoproId = HashMap.HashMap<CoproId, List.List<PollId>>(1, PollModule.isEq, Hash.hash);

    let proposals = HashMap.HashMap<ProposalId, Proposal>(1, PollModule.isEq, Hash.hash);
    let pollProposals = HashMap.HashMap<PollId, List.List<ProposalId>>(1, PollModule.isEq, Hash.hash);

    public query func getName(): async Text {
        return "Belisama"
    }; 

    // Return the principal of the message caller/user identity
    public query({ caller }) func callerPrincipal() : async Principal {
        return caller;
    };

    public shared ({ caller }) func createCopro(copro: CreateCoproDto) {
        let id = coproCounter.bump();
        let newCopro: Copro = {
            coproId= id;
            address= copro.address;
        };
        copros.put(id, newCopro);
        coprosMembership.put(caller, newCopro);
        pollsByCoproId.put(id, List.nil<PollId>());
    };

    public query func getAllCopros(): async [Copro] {
        var array: [Copro] = [];
        for((id, item) in copros.entries()) {
            array := Array.append<Copro>(array, [item]);
        };
        return array;
    };

    public query ({ caller }) func getMyCopro(): async ?Copro {
        coprosMembership.get(caller);
    };

    func getCoproById(id: Nat): ?(Copro) {
        copros.get(id);
    };

    public shared ({ caller }) func joinCopro(id: Nat): async Text {
        switch(getCoproById(id)) {
            case null {
                "not found"
            };
            case (?(result)) {
                coprosMembership.put(caller, result);
                "Joined Copro " # Nat.toText(id) # "."
            }
        };
    };

    //////////////////////////////  Polls  /////////////////////////////////////
    //@Todo Delete this method
    public query func getAllPolls(): async [Poll] {
        var array: [Poll] = [];
        for((id, item) in polls.entries()) {
            array := Array.append<Poll>(array, [item]);
        };
        return array;
    };
    //@Todo Delete this method
    public query func getAllProposals(): async [Proposal] {
        var array: [Proposal] = [];
        for((id, item) in proposals.entries()) {
            array := Array.append<Proposal>(array, [item]);
        };
        return array;
    };

    public shared ({ caller }) func createPoll(poll: CreatePollDto): async Text {
        switch(coprosMembership.get(caller)) {
            case null {
                "You are not in a copro."
            };
            case (?(result)) {
                let id = pollCounter.bump();
                let copro: Copro = result;
                polls.put(id, {
                    pollId = id;
                    coproId = copro.coproId;
                    ownerId = caller;
                    description = poll.description;
                    voters=TrieSet.empty<Principal>();
                });
                pollProposals.put(id, List.nil<ProposalId>());

                var currentPollsByCoproId:?List.List<PollId> = pollsByCoproId.get(copro.coproId);
                let pollAdded = List.push(id, Option.unwrap(currentPollsByCoproId));
                pollsByCoproId.put(copro.coproId, pollAdded);
                "Poll " # Nat.toText(id) # " created."
            }
        };
    };

    public shared ({ caller }) func addProposal(proposal: CreateProposalDto): async Result.Result<Nat, Text> {
        switch(polls.get(proposal.pollId)) {
            case null {
                #err("Poll doesn't exist.")
            };
            case (?(poll)) {
                if (Principal.equal(poll.ownerId, caller) != true) return #err("You are not the poll creator.");
                let id = proposalCounter.bump();
                proposals.put(id, {
                    proposalId=id;
                    pollId=poll.pollId;
                    description=proposal.description;
                    voteCount=0;
                    voters= TrieSet.empty<Principal>();
                });
                var currentPollProposals:?List.List<ProposalId> = pollProposals.get(poll.pollId);
                let proposalAdded = List.push(id, Option.unwrap(currentPollProposals));
                pollProposals.put(poll.pollId,proposalAdded);
                #ok(id);
            }
        };
    };

    public query ({ caller }) func getMyPolls(): async [Poll] {
        switch(coprosMembership.get(caller)) {
            case null {
                // "You are not in a copro."
                []
            };
            case (?(result)) {
                let copro: Copro = result;
                var myPolls: [Poll] = [];
                var pollIds: [PollId] = List.toArray<PollId>(Option.unwrap(pollsByCoproId.get(copro.coproId)));
                for(id in Array.vals(pollIds)){
                    let poll = polls.get(id);
                    myPolls := Array.append<Poll>(myPolls,[Option.unwrap(poll)]);
                };
                myPolls
            }
        };
    };

    public query ({ caller }) func getProposalsByPollId(pollId: Nat): async Result.Result<[Proposal], Text> {
        let myCopro: ?Copro = coprosMembership.get(caller);
        let pollIds: ?List.List<PollId> = Option.map<Copro,List.List<PollId>>(
            myCopro, 
            func (currentCopro){
                Option.get<List.List<PollId>>(pollsByCoproId.get(currentCopro.coproId), List.nil<PollId>());
            }
        );
        switch(pollIds) {
            case null {
                #err("Poll doesn't exist.");
            };
            case (?(result)) {
                var _proposals: [Proposal] = [];
                let _currentPollId: ?PollId = List.find<PollId>(result, func id = id == pollId);
                if(Option.isNull(_currentPollId)) {
                    #err("Poll doesn't exist.");
                } else {
                    let _proposalIds: ?List.List<ProposalId> = Option.map<PollId,List.List<ProposalId>>(
                        _currentPollId,
                        func(pId) {
                            Option.unwrap(pollProposals.get(pId));
                        }
                    );
                    for(id in Iter.fromList<ProposalId>(Option.unwrap(_proposalIds))){
                        let _proposal = proposals.get(id);
                        _proposals := Array.append<Proposal>(_proposals,[Option.unwrap(_proposal)]);
                    };
                    #ok(_proposals);
                }
            };
        };
    };

    //////////////////////////////  Vote  /////////////////////////////////////
    public shared ({ caller }) func vote(proposalId: Nat): async Result.Result<Text, Text> {
        switch(proposals.get(proposalId)) {
            case null {
                #err("Proposal doesn't exist.")
            };
            case (?(proposal)) {
                let poll: Poll = Option.unwrap(polls.get(proposal.pollId));
                let alreadyVoted : Bool = Option.isSome(Array.find<Principal>(TrieSet.toArray(poll.voters), func uid = uid == caller));
                if(alreadyVoted) {
                    #err("You already voted on this poll.");
                } else {
                    let newProposalVoters : TrieSet.Set<Principal> = TrieSet.put<Principal>(proposal.voters, caller, Principal.hash(caller), Principal.equal);
                    let updatedProposal : Proposal = {
                        proposalId=proposal.proposalId;
                        pollId=proposal.proposalId;
                        description=proposal.description;
                        voteCount=TrieSet.size(newProposalVoters);
                        voters=newProposalVoters;
                    };
                    proposals.put(proposalId, updatedProposal);

                    let newPollVoters : TrieSet.Set<Principal> = TrieSet.put<Principal>(poll.voters, caller, Principal.hash(caller), Principal.equal);
                    let updatedPoll : Poll = {
                        pollId=poll.pollId;
                        coproId=poll.coproId;
                        ownerId=poll.ownerId;
                        description=poll.description;
                        voters=newPollVoters;
                    };
                    polls.put(poll.pollId, updatedPoll);
                    #ok("Vote submitted");
                }
            }
        };
    };
};