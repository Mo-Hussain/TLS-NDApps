pragma solidity ^0.4.15;

contract Betting {

  struct Fixture {
    uint fixtureID;
    string home;
    string away;
  }

  struct Bet {
    uint betID;
    address proposer;
    address acceptor;
    bool accepted;
    uint odds;
    uint amount;
    mapping (uint => Fixture) fixture;
  }

  address public master;
  uint betCount;
  uint fixtureCount;

  // maps for current fixtures and bets
  mapping(uint => Fixture) public fixtures;
  mapping(uint => Bet) public bets;
  // array of teams

  modifier onlyMaster() { // Modifier
    require(msg.sender == master);
    _;
  }

  // events for when bets are proposed and accepted and fixtures added or removed

  // constructor
  function Betting() public {
    master = msg.sender;
    betCount = 0;
    fixtureCount = 0;
    addFixture("Arsenal", "Chelsea");
  }

   function addFixture(string _home, string _away) public onlyMaster returns (uint fixtureID){
    fixtureID = fixtureCount++;
    fixtures[fixtureID] = Fixture(fixtureID,_home,_away);
  }

  function proposeBet(uint _fixtureID, uint _odds, uint _amount) public returns (uint betID) {
    betID = betCount++;
    bets[betID] =  Bet(betID, msg.sender, 0, false, _odds, _amount);
    bets[betID].fixture[0] = fixtures[_fixtureID];
  }

  /* // add all teams
  function addTeams(){

  }

  // update the weekly fixtures
  function updateFixtures(){
    // clear map
  }

  function deleteBet() public returns (bool deleted){

  }

  function acceptBet(){

  }
 */
}
