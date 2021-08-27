pragma solidity >=0.6.12;

import "./BEP20.sol";

contract WTLiquidity is BEP20("WTLiquidity", "WTLiquidityAddress"){

    function PayingIn(uint In){
        Token BNB = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        Token WT = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        require(BNB.balanceOf[msg.sender] >= In, "Transfer Error :: Not enough BNB in your account");
        require(WT.balanceOf[msg.sender] >= In, "Transfer Error :: Not enough WT in your account");
        BNB.approve(address(this), In);
        WT.approve(address(this), In);
        BNB.transferFrom(msg.sender, this, In);
        WT.transferFrom(msg.sender, this, In);
        super.transfer(owner, msg.sender, In);
    }
    
    function PayingOut(uint Out){
        Token BNB = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        Token WT = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        require(BNB.balanceOf[this] >= Out, "Transfer Error :: Not enough BNB in the pool");
        require(WT.balanceOf[this] >= Out, "Transfer Error :: Not enough WT in the pool");
        require(balanceOf[msg.sender] >= Out, "Transfer Error :: Not enough Liquidity tokens in your account");
        super.approve(this, Out);
        BNB.transferFrom(this, msg.sender, Out);
        WT.transferFrom(this, msg.sender, Out);
        super.transfer(msg.sender, owner, Out);
    }
    
    function price(){
        Token BNB = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        Token WT = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        price = 
    }
}
