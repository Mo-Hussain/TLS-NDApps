pragma solidity ^0.4.15;

/*
Notes:
- Need to have a function that checks TLS proof of input



*/

contract Betting {

  /* Structure to hold a specific football fixture */
  struct Fixture {
    uint fixtureID;
    string home;
    string away;
    uint home_score;
    uint away_score;
  }

  /* Structure to hold a bet between two parties */
  struct Bet {
    uint betID;
    address proposer;
    address acceptor;
    bool accepted;
    uint odds;
    uint amount;
    uint proposer_home_score;
    uint proposer_away_score;
    address winner;
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
  }

  /* Function to add a fixture to the contract */
   function addFixture(string _home, string _away) public onlyMaster returns (uint fixtureID){
    fixtureID = fixtureCount++;
    fixtures[fixtureID] = Fixture(fixtureID,_home,_away,0,0);
  }

  /* Function allowing a user to propose a bet */
  function proposeBet(uint _fixtureID, uint _odds, uint _amount, uint _home_score, uint _away_score) public returns (uint betID) {
    betID = betCount++;
    bets[betID] =  Bet(betID, msg.sender, 0, false, _odds, _amount,_home_score,_away_score,0);
    bets[betID].fixture[0] = fixtures[_fixtureID];
  }

  /* Best not to concatenate strings in smart contract as may consume unecessary gas */
  /* Should concatenate strings and the like in the front-end */
  function getFixtureHomeTeam(uint _fixtureID) public constant returns (string) {
    return fixtures[_fixtureID].home;
  }

  function getFixtureAwayTeam(uint _fixtureID) public constant returns (string) {
    return fixtures[_fixtureID].away;
  }

  /* Need to be able to get number of fixtures and number of bets */
  function getNumberOfBets() public constant returns (uint) {
    return betCount;
  }

  function getNumberOfFixtures() public constant returns (uint) {
    return fixtureCount;
  }

  /* Function to accept bet */
  function acceptBet(uint _betID) public {
    betCount--;
    bets[_betID].acceptor = msg.sender;
    bets[_betID].accepted = true;
  }

  /* Function to input the scores of a fixture */
  function inputScore(uint _fixtureID, uint _home_score, uint _away_score) public {
    fixtures[_fixtureID].home_score = _home_score;
    fixtures[_fixtureID].away_score = _away_score;
  }

  /* Function to get the winner of a bet */


  /* Function to get all outstanding bets that have not been accepted */
  /* Matt - I think we should do this on the front-end, looping through bets and just getting those accepted */


  /* // add all teams - Matt - I am not sure we need this
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
