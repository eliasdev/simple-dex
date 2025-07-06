// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract SimpleDEX {
    address public owner;
    IERC20 public tokenA;
    IERC20 public tokenB;

    uint256 public reserveA;
    uint256 public reserveB;

    event LiquidityAdded(uint256 amountA, uint256 amountB);
    event LiquidityRemoved(uint256 amountA, uint256 amountB);
    event SwappedAforB(uint256 amountAIn, uint256 amountBOut);
    event SwappedBforA(uint256 amountBIn, uint256 amountAOut);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor(address _tokenA, address _tokenB) {
        owner = msg.sender;
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }

    function addLiquidity(uint256 amountA, uint256 amountB) public onlyOwner {
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "Transfer failed for tokenA");
        require(tokenB.transferFrom(msg.sender, address(this), amountB), "Transfer failed for tokenB");

        reserveA += amountA;
        reserveB += amountB;

        emit LiquidityAdded(amountA, amountB);
    }

    function removeLiquidity(uint256 amountA, uint256 amountB) public onlyOwner {
        require(amountA <= reserveA && amountB <= reserveB, "Insufficient reserves");

        reserveA -= amountA;
        reserveB -= amountB;

        require(tokenA.transfer(msg.sender, amountA), "Transfer failed for tokenA");
        require(tokenB.transfer(msg.sender, amountB), "Transfer failed for tokenB");

        emit LiquidityRemoved(amountA, amountB);
    }

    function swapAforB(uint256 amountAIn) public {
        require(amountAIn > 0, "Amount must be greater than zero");
        require(tokenA.transferFrom(msg.sender, address(this), amountAIn), "Transfer failed for tokenA");

        uint256 amountBOut = getAmountOut(amountAIn, reserveA, reserveB);
        require(amountBOut > 0 && amountBOut <= reserveB, "Insufficient liquidity");

        reserveA += amountAIn;
        reserveB -= amountBOut;

        require(tokenB.transfer(msg.sender, amountBOut), "Transfer failed for tokenB");

        emit SwappedAforB(amountAIn, amountBOut);
    }

    function swapBforA(uint256 amountBIn) public {
        require(amountBIn > 0, "Amount must be greater than zero");
        require(tokenB.transferFrom(msg.sender, address(this), amountBIn), "Transfer failed for tokenB");

        uint256 amountAOut = getAmountOut(amountBIn, reserveB, reserveA);
        require(amountAOut > 0 && amountAOut <= reserveA, "Insufficient liquidity");

        reserveB += amountBIn;
        reserveA -= amountAOut;

        require(tokenA.transfer(msg.sender, amountAOut), "Transfer failed for tokenA");

        emit SwappedBforA(amountBIn, amountAOut);
    }

    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256) {
        uint256 amountInWithFee = amountIn * 997; // 0.3% fee
        uint256 numerator = amountInWithFee * reserveOut;
        uint256 denominator = (reserveIn * 1000) + amountInWithFee;
        return numerator / denominator;
    }

    function getPrice(address _token) public view returns (uint256) {
        if (_token == address(tokenA)) {
            return reserveB * 1e18 / reserveA;
        } else if (_token == address(tokenB)) {
            return reserveA * 1e18 / reserveB;
        } else {
            revert("Token not supported");
        }
    }
}
