/// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12;

import "./BEP20.sol";
import "./Token.sol";

contract WTLiquidity is BEP20("WTLiquidityTokenA", "WTLA"){

    function PayingIn(uint In)public{
        Token BNB = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        Token WT = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        require(BNB.balanceOf(msg.sender) >= In, "Transfer Error :: Not enough BNB in your account");
        require(WT.balanceOf(msg.sender) >= In, "Transfer Error :: Not enough WT in your account");
        if(balanceOf(address(this)) >= (In + 1000)){
            BNB.approve(address(this), In);
            WT.approve(address(this), In);
            BNB.transferFrom(msg.sender, address(this), In);
            WT.transferFrom(msg.sender, address(this), In);
            super.transferFrom(address(this), msg.sender, In);
        }else if(balanceOf(address(this)) >= (In + 1)){
            BNB.approve(address(this), In);
            WT.approve(address(this), In);
            BNB.transferFrom(msg.sender, address(this), In);
            WT.transferFrom(msg.sender, address(this), In);
            super.transfer(msg.sender, In);
            WT.transfer(0x08041eC6e81C0b2654C34209e25FeecB46A7D852, 1); /// To notify me to send the mint command 
        }else{
            WT.transfer(0x08041eC6e81C0b2654C34209e25FeecB46A7D852, 1); /// To notify me to send the mint command 
        }
    }
    
    function PayingOut(uint Out)public{
        Token BNB = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        Token WT = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        require(BNB.balanceOf(address(this)) >= Out, "Transfer Error :: Not enough BNB in the pool");
        require(WT.balanceOf(address(this)) >= Out, "Transfer Error :: Not enough WT in the pool");
        require(balanceOf(msg.sender) >= Out, "Transfer Error :: Not enough Liquidity tokens in your account");
        super.approve(address(this), Out);
        BNB.transferFrom(address(this), msg.sender, Out);
        WT.transferFrom(address(this), msg.sender, Out);
        super.transferFrom(msg.sender, address(this), Out);
    }
    
    function price()public returns(uint){
        Token BNB = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        Token WT = Token(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);/// replace with token addresses
        uint Price = ((BNB.balanceOf(address(this)) / WT.balanceOf(address(this))) * 100);
        return Price;
    }
}
