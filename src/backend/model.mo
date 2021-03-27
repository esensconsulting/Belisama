import Principal "mo:base/Principal";
import Time "mo:base/Time";

module {
    public type ItemId = Nat;
    public type LoanId = Nat;
    public type UserId = Principal;

    public type Item = {
        id: ItemId;
        name: Text;
        description: Text;
        loanId: ?LoanId;
    };

    public func isEq(x: Nat, y: Nat): Bool {
        x == y;
    };

    public type Loan = {
        loanId: LoanId;
        itemId: ItemId;
        borrowerId: UserId;
        begin: Int;
        end: ?Int;
    };

    public type CreateItemDto = {
        name: Text;
        description: Text;
    };

    public type ItemDto = {
        id: Nat;
        name: Text;
        description: Text;
        borrower: ?UserId;
    };

};