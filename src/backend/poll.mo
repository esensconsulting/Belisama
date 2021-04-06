import Principal "mo:base/Principal";
import Time "mo:base/Time";

module {
    public type PollId = Nat;
    public type CoproId = Nat;
    public type ProposalId = Nat;

    public func isEqPrincipal(x: Principal, y: Principal): Bool {
        Principal.equal(x, y);
    };
    public func isEq(x: Nat, y: Nat): Bool {
        x == y;
    };
    
    public type Poll = {
        pollId: PollId;
        coproId: CoproId;
        ownerId: Principal;
        description: Text;
    };
    public type CreatePollDto = {
        description: Text;
    };
    public type Proposal = {
        proposalId: ProposalId;
        pollId: PollId;
        description: Text;
        voteCount: Nat;
    };
    public type CreateProposalDto = {
        pollId: PollId;
        description: Text;
    };
};