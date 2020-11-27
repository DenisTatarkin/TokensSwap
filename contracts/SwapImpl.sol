pragma solidity ^0.5.1;
import '@openzeppelin/upgrades/contracts/Initializable.sol';
import './Ownable.sol';
import './TokenFOPF.sol';
import './TokenFIVT.sol';

contract SwapImpl is Initializable{
    //Using initialize instead of constructor.
    function initialize (address _userA, uint256 _tokenAcount, uint256 _tokenBcount) public {  
        require(_tokenAcount > 0 && _tokenBcount > 0);
        tokenA = TokenFOPF(0xd39eeE2D3AF27438e754736F6FeEf04412aAb9EF);
        tokenB = TokenFIVT(0xF6952a114412B49115Aed774C1214246E7D62fb6);
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