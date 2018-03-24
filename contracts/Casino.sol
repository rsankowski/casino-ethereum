pragma solidity 0.4.20;

contract Casino {
  address public owner;
  uint256 public minimumBet;
  uint256 public totalBet;
  uint256 public numberOfBets;
  uint256 public maxAmountsOfBets = 100;
  address[] public players;

  struct Player { //struct is a javascript like object that can store information
    uint256 amountBet;
    uint256 numberSelected;
  }

  //the address of the player and => the user info
  //with this mapping we can query the amountBet by typing playerInfo[here_goes_his_address].amountBet in the console
  mapping(address => Player) public playerInfo; //this creates a publicly readable mapping with the player info

  function Casino() public { //this is the constructor function since it has the same name as the contract
    owner = msg.sender;
    if (_minimumBet != 0) minimumBet = _minimumBet;
  }

  function kill() public {
    if(msg.sender == owner) selfdestruct(owner);
  }
}

function checkPlayerExists(address player) public constant returns(bool){ //constant keyword indicates that the function is free because it queries an existing value
  for (uint256 i=0; i<players.length; i++) {
    if(players[i] == player) return true;
  }
  return false;
}

//to bet for a number between 1 and 10 both inclusive
function bet(uint256 numberSelected) public payable {
  //checkPlayerExists checks if the sender has already played
  require(!checkPlayerExists(msg.sender)); // require function is like an if statement that must return "true";
  //if the condition inside the require function returns false the function stops and ether paid is reverted to the sender
  require(numberSelected >=1 && numberSelected <= 10);
  require(msg.value >= minimumBet);

  playerInfo[msg.sender].amountBet = msg.value;
  playerInfo[msg.sender].numberSelected + numberSelected;
  numberOfBets++; // counter to see how many bets there are
  players.push(msg.sender);
  totalBet += msg.value;
  if(numberOfBets >= maxAmountsOfBets) generateNumberWinner();
}
