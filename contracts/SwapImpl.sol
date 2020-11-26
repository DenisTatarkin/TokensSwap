pragma solidity ^0.5.1;
import '@openzeppelin/upgrades/contracts/Initializable.sol';
import './Ownable.sol';
import './TokenFOPF.sol';
import './TokenFIVT.sol';

contract SwapImpl is Initializable{
    //Using initialize instead of constructor.
    function initialize (address _userA, uint256 _tokenAcount, uint256 _tokenBcount) public {  
        require(_tokenAcount > 0 && _tokenBcount > 0);
        tokenA = TokenFOPF(0x2725d6D4108aE8d70489E9aFC23443f8aB42895f);
        tokenB = TokenFIVT(0x6B40527F7A211562a8b85736E1Cf4de96d92A0Cc);
        tokenAcount = _tokenAcount;
        tokenBcount = _tokenBcount;
        userA = _userA;
    }
    
    TokenFOPF tokenA; 
    TokenFIVT tokenB;
    uint256 public tokenAcount;  
    uint256 public tokenBcount;
    address public userA;
    address public userB;
    bool public done = false;
    
    function acceptSwap() public{
        require(!done);
        userB = msg.sender;
        tokenA.transferFrom(userA, userB, tokenAcount);
        tokenB.transferFrom(userB, userA, tokenBcount);
        done = true;
    }
}