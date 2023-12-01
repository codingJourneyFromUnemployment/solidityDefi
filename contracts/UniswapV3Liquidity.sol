// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

interface INonFungiblePositionManager {
  struct MintParams {
    address token0;
    address token1;
    uint24 fee;
    int24 tickLowner;
    int24 tickUpper;
    uint amount0Desired;
    uint amount1Desired;
    uint amount0Min;
    uint amount1Min;
    address recipient;
    uint deadline;
  }

  function mint(
    MintParams calldata params
  ) external payable returns (uint tokenId, uint128 liquidity, uint amount0, uint amount1);

  struct IncreaseLiquidityParams {
    uint tokenId;
    uint amount0Desired;
    uint amount1Desired;
    uint amount0Min;
    uint amount1Min;
    uint deadline;
  }

  function increaseLiquidity (
    IncreaseLiquidityParams calldata params 
  ) external payable returns (uint128 liquidity, uint amount0, uint amount1);

  struct DecreaseLiquidityParams {
    uint tokenId;
    uint128 liquidity;
    uint amount0Min;
    uint amount1Min;
    uint deadline;
  }

  function decreaseLiquidity (
    DecreaseLiquidityParams calldata params
  ) external payable returns (uint amount0, uint amount1);

  struct CollectParams {
    uint tokenId;
    address recipient;
    uint128 amount0Max;
    uint128 amount1Max;
  }

  function collect(
    CollectParams calldata params
  ) external payable returns (uint amount0, uint amount1);
}

contract UniswapV3Liquidity {
  IERC20 private constant dai = IERC20(DAI);
  IERC20 private constant weth = IERC20(WETH);

  int24 private constant MIN_TICK = -887220;
  int24 private constant MAX_TICK = 887220;
  int24 private constant TICK_SPACING = 60;

  INonFungiblePositionManager public positionManager = INonFungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);

  function onERC721Received(
    address operator,
    address from,
    uint256 tokenId,
    bytes calldata data
  ) external pure returns (bytes4) {
    return IERC721Receiver.onERC721Received.selector;
  }
}



