#[starknet::interface]
trait Ilayer3chain<TContractState> {
    fn upload_block(ref self: TContractState, block: L3Chain::L3Block);
}

#[starknet::contract]
mod L3Chain {
    use array::ArrayTrait;

    #[derive(Drop, Serde)]
    struct L3Block {
        height: felt252,
        block_hash: Array<felt252>, 
        state_root: Array<felt252>,
        txns_root: Array<felt252>,
    }

    #[storage]
    struct Storage {
        chain: LegacyMap::<felt252, L3Block>,
    }
    

    #[external(v0)]
    impl L3Chain of super::Ilayer3chain<ContractState>{
        fn upload_block(ref self: ContractState, block: L3Block) {
            self.chain.write(block.height, block)
        }
    }
    
}