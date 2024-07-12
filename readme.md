# Simple Starknet Token Transfer Contract


This is a simple token transfer contract on Starknet that illustrates how to send tokens to the contract and out from the contract to a given address.


For this case, we are transferring from the `caller address` to the `contract` and transferring from the `contract` to the `caller address`

We have 3 methods that is:

1. `deposit` - To deposit to the contract
2. `withdraw` - To withdraw from the contract
3. `get_token_balance` - To get the balance of a given token in the contract.

To test out this contract, we have deployed a sample on `Sepolia` Testnet.

The contract address is `0x05308F66FE9D42938E0cf7B61a53633C3ba3357aBEcb1Da14E922A5CAB5fdB03`.

To test out the contract: 
1. Open Contract in [voyager](https://sepolia.voyager.online/contract/0x05308f66fe9d42938e0cf7b61a53633c3ba3357abecb1da14e922a5cab5fdb03)
2. Open Contract in [Starkscan](https://sepolia.starkscan.co/contract/0x05308f66fe9d42938e0cf7b61a53633c3ba3357abecb1da14e922a5cab5fdb03)
3. Use Starkdeployer by importing the contract [here](https://stark-deployer.vercel.app/import). Pass in Transfer as contract Name.

WARNING: - This contract is entirely not secure, Reason: Anybody can withdraw what they didn't deposit.