pragma solidity ^0.8.0;

contract Will{
    address owner;
    uint fortune;
    bool deceased;

    constructor () public payable {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    // create modifier to ensure that only owner calls contract
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // modifier to check if owner is dead
    modifier mustBeDeceased() {
        require(deceased == true);
        _;
    }

    // store list of family wallets
   address payable [] familyWallets;

    // map through inheritance
   mapping (address=>uint) inheritance;

    function setInheritance (address payable wallet, uint amount)public onlyOwner {
         familyWallets.push(wallet);
          inheritance[wallet] = amount;
    }

    // pay each family member based on their details\
    function payout() private mustBeDeceased {
        for (uint256 i = 0; i < familyWallets  .length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    function isDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}