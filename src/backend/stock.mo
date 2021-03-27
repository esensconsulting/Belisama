import Array "mo:base/Array";
import AssocList "mo:base/AssocList";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Model "./model";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor Inventory {
    public type Item = Model.Item;
    public type Loan = Model.Loan;
    public type ItemId = Model.ItemId;
    public type LoanId = Model.LoanId;
    public type UserId = Model.UserId;
    public type CreateItemDto = Model.CreateItemDto;
    public type ItemDto = Model.ItemDto;

    object counter {
        var count = 0;
        public func inc() { count += 1 };
        public func read() : Nat { count };
        public func bump() : Nat {
            inc();
            read()
        };
    };

    object loanCounter {
        var count = 0;
        public func inc() { count += 1 };
        public func read() : Nat { count };
        public func bump() : Nat {
            inc();
            read()
        };
    };
    
    let inventory = HashMap.HashMap<ItemId, Item>(1, Model.isEq, Hash.hash);
    let loans = HashMap.HashMap<LoanId, Loan>(1, Model.isEq, Hash.hash);
    let loansByItem = HashMap.HashMap<ItemId, List.List<LoanId>>(1, Model.isEq, Hash.hash);

    public func createOne(item: CreateItemDto) {
        let id = counter.bump();

        inventory.put(id, {
            id= id;
            name= item.name;
            description= item.description;
            loanId = null
        });
    };

    public query func getAllItems(): async [ItemDto] {
        var items: [ItemDto] = [];
        for((id, item) in inventory.entries()) {
            items := Array.append<ItemDto>(items, [mapItem(item)]);
        };
        return items;
    };

    public query func getAllLoans(): async [Loan] {
        var arrLoans: [Loan] = [];
        for((id, loan) in loans.entries()) {
            arrLoans := Array.append<Loan>(arrLoans, [loan]);
        };
        return arrLoans;
    };
    
    func getOne(id: Nat): ?(Item) {
        inventory.get(id)
    };

    func mapItem(item: Item): ItemDto {        
        var borrowerId:?(?UserId) = Option.map<LoanId, ?UserId>(
            item.loanId,
            func (loanId) : ?UserId {
                Option.map<Loan, UserId>(
                    loans.get(loanId),
                    func (loan) : UserId {
                        loan.borrowerId;
                    }
                );
            }
        );

        {
            id= item.id;
            name= item.name;
            description= item.description;
            borrower= Option.get(borrowerId, null)
        };
    };

    func computeLoan(item: Item, caller: ?UserId): (Item, Loan) {
        var loan:?Loan = Option.map<LoanId, Loan>(
            item.loanId,
            func (loanId) {
                let loan = loans.get(loanId);
                assert(Option.isSome(loan));
                Option.unwrap(loan);
            }
        );

        let loanId = loanCounter.bump();

        if (Option.isNull(loan)) {
            assert(Option.isSome(caller));

            (
                {
                    id=item.id;
                    name=item.name;
                    description=item.description;
                    loanId=?(loanId);
                },
                {
                    loanId=loanId;
                    itemId=item.id;
                    borrowerId=Option.unwrap(caller);
                    begin=Time.now();
                    end=null;
                }
            )
        } else {
            (
                {
                    id=item.id;
                    name=item.name;
                    description=item.description;
                    loanId=null;
                },
                {
                    loanId=loanId;
                    itemId=item.id;
                    borrowerId=Option.unwrap(loan).borrowerId;
                    begin=Option.unwrap(loan).begin;
                    end=?(Time.now());
                }
            )
        }
    };

    func registerItemLoan(itemId: ItemId, loanId: LoanId) {
        var itemLoans:?List.List<LoanId> = loansByItem.get(itemId);
        
        if (Option.isNull(itemLoans)) {
            itemLoans := ?(List.nil<LoanId>());
        };

        let newItemLoans = List.push(loanId, Option.unwrap(itemLoans));
        
        loansByItem.put(itemId, newItemLoans);
    };

    func borrow(itemId: ItemId, caller: ?UserId): async Text {
        switch(getOne(itemId)) {
            case null {
                "Item " # Nat.toText(itemId) # " not found."
            };
            case (?(result)) {
                let itemLoan:(Item, Loan) = computeLoan(result, caller);

                let item:Item = itemLoan.0;
                let loan:Loan = itemLoan.1;

                loans.put(loan.loanId, loan);
                inventory.put(item.id, item);
                registerItemLoan(item.id, loan.loanId);
                
                "Item " # Nat.toText(itemId) # " borrowed."
            }
        };
    };

    public shared ({ caller }) func borrowItem(id: Nat): async Text {
        await borrow(id, ?(caller));
    };

    public shared func unborrowItem(id: Nat): async Text {
        await borrow(id, null);
    };


};