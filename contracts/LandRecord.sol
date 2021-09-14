
pragma solidity >=0.4.22 <0.8.0;

pragma experimental ABIEncoderV2;


contract LandRecord {
    
    
    struct Land  {
        address ownerAddr;
        string streetAddress;
        string ownerName;
        string ownerID;
        uint price;
        byte statusForPurchase;
    }
 
    
    
    Land[] public lands;
    
    Land [] public personalProperties;
    
    address public owner;
    
    modifier onlyOwner {
        require (owner==msg.sender);
        _;
    }
    
    constructor() public {
        owner= msg.sender;
    }
    
     function addLand (string memory _addr , string memory _Oname, string memory _Id, uint _price, address OwnAddr ) public onlyOwner {
        
        Land memory a;
        
        a.ownerAddr = OwnAddr;
        a.streetAddress = _addr;
        a.ownerName = _Oname;
        a.ownerID = _Id;
        a.price = _price;
        a.statusForPurchase = 'A';
        
        lands.push(a);
    }
    
    
    function transferOwnerShip (address from ,string memory toName, string memory toID, address to , string memory addr) public payable {
        
        for (uint i=0; i<lands.length; i++){
            
            if (keccak256(bytes(lands[i].streetAddress))==keccak256(bytes(addr))){
                
                if (lands[i].ownerAddr == from)
                {
                    
                    if (lands[i].statusForPurchase == 'A')
                    {
                        
                    require (msg.value >= 1000000000000000000);
                        
                    lands[i].ownerAddr = to;
                    lands[i].ownerName= toName;
                    lands[i].ownerID = toID;
                    }
                    else {
                        revert ('Disputed Land');
                    }
                    
                    
                }
                
            }
            
        }
        
       
        
    }
    
    
    function adddisputeLand (string memory  addr) public payable {
        
         for (uint i=0; i< lands.length; i++)
        {
            if (keccak256(bytes(lands[i].streetAddress))==keccak256(bytes(addr)))
            {
                lands[i].statusForPurchase = 'D';
            }
            
        }
        
    }
    
    function handleDispute (string memory  addr)public onlyOwner {
        
        
         for (uint i=0; i< lands.length; i++)
        {
            if (keccak256(bytes(lands[i].streetAddress))==keccak256(bytes(addr)))
            {
                lands[i].statusForPurchase = 'A';
            }
            
        }
    }
    
    
    function ViewMyLands (address addr) public payable returns (Land[] memory rec) {
        
        
        
        delete personalProperties;
        for (uint i=0; i< lands.length; i++)
        {
            if (lands[i].ownerAddr== addr)
            {
                personalProperties.push(lands[i]);
            }
            
        }
         return personalProperties;
    }
    
    function ViewAllLands () public view returns (Land[] memory rec) {
        return lands;
    }
  
    
}

