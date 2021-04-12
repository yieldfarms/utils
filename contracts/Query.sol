pragma solidity 0.5.16;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title Balance Query
/// @author Chainvisions
/// @notice Contract for querying ERC20 balances

contract Query {

    /*
    * Allows for querying the balances of all tokens specified.
    */
    function query(address _target, address[] memory _tokens) public view returns (uint256[] memory) {
        uint256[] memory balances = new uint256[](_tokens.length);
        for(uint256 i = 0; i<_tokens.length; i++) {
            uint256 bal = IERC20(_tokens[i]).balanceOf(_target);
            balances[i] = bal;
        }
        return balances;
    }

    /*
    * Allows for a contract using a specific function signature.
    */

    function queryWithSignature(address _target, address[] memory _addresses, string memory _signature) public view returns (uint256[] memory) {
        uint256[] memory numbers = new uint256[](_addresses.length);
        for(uint256 i = 0; i < _addresses.length; i++) {
            (, bytes memory data) = _addresses[i].staticcall(abi.encodeWithSignature(_signature, _target));
            numbers[i] = abi.decode(data, (uint256));
        }
        return numbers;
    }

}