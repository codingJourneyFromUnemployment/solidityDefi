//Constant sum AMM X + Y = K Tokens trade one to one.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CSAMM {
  IERC20 public immutable token0;
  IERC20 public immutable token1;

  uint public reserve0;
  uint public reserve1;

  uint public totalSupply;
  mapping(address => uint) public balanceOf;

  constructor(address _token0, address _token1) {
      // NOTE: This contract assumes that token0 and token1
      // both have same decimals
      token0 = IERC20(_token0);
      token1 = IERC20(_token1);
  }

  function _mint(address _to, uint _amount) private {
      balanceOf[_to] += _amount;
      totalSupply += _amount;
  }

  function _burn(address _from, uint _amount) private {
    balanceOf[_from] -= _amount;
    totalSupply -= _amount;
  }

  function _update(uint _res0, uint _res1) private {
    reserve0 = _res0;
    reserve1 = _res1;
  }

  function swap(address _tokenIn, uint _amountIn) external returns (uint amountOut) {
    require(
      _tokenIn == address(token0) || _tokenIn == address(token1),
      "CSAMM: Invalid token"
    );

    bool isToken0 = _tokenIn == address(token0);

    
  }


}