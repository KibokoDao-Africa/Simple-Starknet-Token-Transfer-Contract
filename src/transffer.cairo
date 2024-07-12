use starknet::ContractAddress;

#[starknet::interface]
pub trait ITransffer<TContractState> {
    fn deposit(ref self: TContractState, token_address: ContractAddress, amount: u256);
    fn withdraw(ref self: TContractState, token_address: ContractAddress, amount: u256);
    fn get_contract_balance(self: @TContractState, token_address: ContractAddress) -> u256;
}

#[starknet::contract]
mod Transffer {
    use transffer::erc20::IERC20DispatcherTrait;
    use transffer::erc20::IERC20Dispatcher;
    use super::ContractAddress;
    use starknet::{get_caller_address, get_contract_address};

    #[storage]
    struct Storage {
        balances: LegacyMap<ContractAddress, u256>,
    }

    #[abi(embed_v0)]
    impl TransfferImpl of super::ITransffer<ContractState> {
        fn deposit(ref self: ContractState, token_address: ContractAddress, amount: u256) {
            let token_dispatcher = IERC20Dispatcher { contract_address: token_address };
            let has_transferred = token_dispatcher
                .transferFrom(
                    sender: get_caller_address(), recipient: get_contract_address(), amount: amount
                );

            if has_transferred {
                self.balances.write(token_address, self.balances.read(token_address) + amount)
            }
        }

        fn withdraw(ref self: ContractState, token_address: ContractAddress, amount: u256) {
            let contract_token_balance = self.balances.read(token_address);
            assert(amount < contract_token_balance, 'Not enough balance');
            let token_dispatcher = IERC20Dispatcher { contract_address: token_address };
            let has_transferred = token_dispatcher
                .transfer(recipient: get_caller_address(), amount: amount);

            if has_transferred {
                self.balances.write(token_address, self.balances.read(token_address) - amount)
            }
        }
        fn get_contract_balance(self: @ContractState, token_address: ContractAddress) -> u256 {
            self.balances.read(token_address)
        }
    }
}
