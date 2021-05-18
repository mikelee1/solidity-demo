// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity >=0.8.0;

interface C2Interface{
    function getName() external pure returns ( string memory );
}

contract UpgradableAdmin {
    address internal admin;
    
    constructor(){
        admin = msg.sender;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "no access");
        _;
    }
    
    function getAdmin() external view returns (address) {
        return admin;
    }
    
        function setAdmin(address _newAdmin) external onlyAdmin {
        admin = _newAdmin;
    }
}

contract C1 is UpgradableAdmin{
    
    address internal c2;
    
    constructor(address _c2){
        c2 = _c2;
    }
    
    function getC2Name() public view returns (string memory) {
        return C2Interface(c2).getName();
    }
}

contract C2{

    constructor(){}
    
    function getName() public pure returns ( string memory ) {
        return "i am c2";
    }
}