#[starknet::interface]
trait Ilayer3chain<TContractState> {
    fn upload_block(ref self: TContractState, block: L3Chain::L3Block);
}

#[starknet::contract]
mod L3Chain {
    use array::ArrayTrait;

    #[storage]
    struct Storage {
        chain: Array<L3Block>,
    }

    #[derive(Serde)]
    struct L3Block {
        height: felt252,
        block_hash: Array<felt252>, 
        state_root: Array<felt252>,
        txns_root: Array<felt252>,
    }

    #[external(v0)]
    impl L3Chain of super::Ilayer3chain<ContractState>{
        fn upload_block(ref self: ContractState, block: L3Block) {
            self.chain.write(block)
        }
    }
    
}