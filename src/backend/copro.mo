import Principal "mo:base/Principal";
import Time "mo:base/Time";

module {
    public type CoproId = Nat;

    public func isEqPrincipal(x: Principal, y: Principal): Bool {
        Principal.equal(x, y);
    };
    public func isEq(x: Nat, y: Nat): Bool {
        x == y;
    };
    
    public type Copro = {
        coproId: CoproId;
        address: Text;
    };
    public type CreateCoproDto = {
        address: Text;
    };
};