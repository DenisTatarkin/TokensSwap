pragma solidity ^0.5.1;
import '@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol';

contract SwapFactory is ProxyFactory {
  address public implementationContract;
  constructor (address _implementationContract) public {
    implementationContract = _implementationContract;
  }

  function createSwap(uint256 _tokenAcount, uint256 _tokenBcount) public returns (address){
    bytes memory payload = abi.encodeWithSignature("initialize(address,uint256,uint256)", 
                                                    msg.sender, _tokenAcount, _tokenBcount);
    address proxy = deployMinimal(implementationContract, payload);
    return proxy;
  }
}