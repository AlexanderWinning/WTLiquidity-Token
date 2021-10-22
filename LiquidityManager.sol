// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12;

import "IBEP20.sol";

contract LiquidityManager {
    IBEP20 constant BNB = IBEP20(0x08041eC6e81C0b2654C34209e25FeecB46A7D852); // Change
    IBEP20 constant WT = IBEP20(0x08041eC6e81C0b2654C34209e25FeecB46A7D852); // Change
    IBEP20 constant WTLT = IBEP20(0x08041eC6e81C0b2654C34209e25FeecB46A7D852);

    function PayingIn(uint256 In) public {
        require(
            BNB.balanceOf(msg.sender) >= In,
            "Transfer Error :: Not enough BNB in your account"
        );
        require(
            WT.balanceOf(msg.sender) >= In,
            "Transfer Error :: Not enough WT in your account"
        );
        BNB.approve(address(this), In);
        WT.approve(address(this), In);
        BNB.transferFrom(msg.sender, address(this), In);
        WT.transferFrom(msg.sender, address(this), In);
        WTLT.mint(In);
        WTLT.transfer(msg.sender, In);
    }

    function PayingOut(uint256 Out) public {
        require(
            BNB.balanceOf(address(this)) >= Out,
            "Transfer Error :: Not enough BNB in the pool"
        );
        require(
            WT.balanceOf(address(this)) >= Out,
            "Transfer Error :: Not enough WT in the pool"
        );
        require(
            WTLT.balanceOf(msg.sender) >= Out,
            "Transfer Error :: Not enough Liquidity tokens in your account"
        );
        BNB.transferFrom(address(this), msg.sender, Out);
        WT.transferFrom(address(this), msg.sender, Out);
        WTLT._burnFrom(address(msg.sender), Out);
    }

    function PriceFind() public view returns (uint256) {
        /// WARNING MUST BE DIVIDED BY 100 AT THE CALLED END
        return ((WT.balanceOf(address(this)) / BNB.balanceOf(address(this))) *
            100); /// Would mostly return a decimal which is not allowed as it is not implementented
    }

    function IPriceFind(uint256 amount, bool Buy) public returns (uint256) {
        /// WARNING :: MUST BE DIVIDED BY 100 AT THE CALLED END, Only issued by contracts that are actually trading
        uint256 Price;
        uint256 K1 = ((WT.balanceOf(address(this)) /
            BNB.balanceOf(address(this))) * 100); /// Would mostly return a decimal which is not allowed as it is not implementented
        if (Buy == true) {
            Price = ((WT.balanceOf(address(this)) -
                ((K1 / 100) * (amount / 2)) /
                BNB.balanceOf(address(this)) +
                (amount / 2)) * 100); /// Likely to throw a decimal point
            /// A1 is your token A2 is the other token in the pair
            /// Price = A1 - (K1 * (amount / 2)) / A2 + (amount / 2) My formula for buying using Automated Market Making
        } else {
            Price = ((WT.balanceOf(address(this)) +
                ((amount / 2)) /
                BNB.balanceOf(address(this)) -
                ((1 / (K1 / 100)) * (amount / 2))) * 100); /// Likely to throw a decimal point
            /// A1 is your token A2 is the other token in the pair
            /// Price = A1 + (amount / 2) / A2 - (1 / K1) * (amount / 2) My formula for selling using Automated Market Making
        }
        return Price;
    }
}
