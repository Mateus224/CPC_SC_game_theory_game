pragma solidity ^0.4.24;


contract lotteryGame {
    
    address public creator;
    address public owner;
    uint256 public unlockDate;
    uint256 public createdAt;


    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    struct gameEnviroment{
       uint256 entry;
       uint16 fromNumber;
       uint16 toNumber;  
    }
    
    gameEnviroment gameEnv;
    
    struct accountData {
        uint256 payed;
        uint256 yourLuckyNumber;
        uint8 group;
        bool winner;
    }
    mapping (address => accountData) accounts;
    address[] public accountArray;


    function defineGameBorders(uint16 NewFromNuber,uint16 NewToNumber) onlyOwner public {
        gameEnv.fromNumber=NewFromNuber;
        gameEnv.toNumber=NewToNumber;
    }

    function defineEntry(uint256 newEntry) onlyOwner public {
        gameEnv.entry=newEntry;
    }

    function TimeLockedWallet(
        address _creator,
        address _owner,
        uint256 _unlockDate
    ) public {
        creator = _creator;
        owner = _owner;
        unlockDate = now+180; //86400
        createdAt = now;
    }

    // keep all the ether sent to this address
    function() payable public { 
        require(msg.value>gameEnv.entry);
        emit Received(msg.sender, msg.value);
        accounts[msg.sender].payed=msg.value;
        //accountArray.push()
        calculateLuckyNumer();
        
    }
    
    function sort(){
        
    }
    
    function calculateLuckyNumer(){
        accounts[msg.sender].yourLuckyNumber=msg.value % gameEnv.entry;
    }

    // callable by owner only, after specified time
    function withdraw() onlyOwner public {
       require(now >= unlockDate);
       //now send all the balance
       msg.sender.transfer(this.balance);
       emit Withdrew(msg.sender, this.balance);
    }


    function info()  view public returns(address, address, uint256, uint256, uint256) {
        emit Info(creator, owner, unlockDate, createdAt, this.balance);
        //return (creator, owner, unlockDate, createdAt, this.balance);
    }
    event Info(address creator, address owner, uint256 unlockDate, uint256 createdAt, uint256 balance);
    event Received(address from, uint256 amount);
    event Withdrew(address to, uint256 amount);
}
