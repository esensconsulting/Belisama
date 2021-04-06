import Array "mo:base/Array";
import AssocList "mo:base/AssocList";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor Belisama {
    func isEqPrincipal(x: Principal, y: Principal): Bool {
        Principal.equal(x, y);
    };
    func isEq(x: Nat, y: Nat): Bool {
        x == y;
    };

    public type CoproId = Nat;
    public type Copro = {
        coproId: CoproId;
        address: Text;
    };
    public type CreateCoproDto = {
        address: Text;
    };
    object coproCounter {
        var count = 0;
        public func inc() { count += 1 };
        public func read() : Nat { count };
        public func bump() : Nat {
            inc();
            read()
        };
    };

    let copros = HashMap.HashMap<CoproId, Copro>(1, isEq, Hash.hash);
    let coprosMembership = HashMap.HashMap<Principal, Copro>(1, isEqPrincipal, Principal.hash);

    public query func getName(): async Text {
        return "Hi Belisama"
    }; 

    public shared func createCopro(copro: CreateCoproDto) {
        let id = coproCounter.bump();

        copros.put(id, {
            coproId= id;
            address= copro.address;
        });
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
                "Copro " # Nat.toText(id) # " not found."
            };
            case (?(result)) {
                coprosMembership.put(caller, result);
                
                "Joind Copro " # Nat.toText(id) # "."
            }
        };
    };
};