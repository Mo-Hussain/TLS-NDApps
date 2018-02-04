var Betting = artifacts.require("./Betting.sol");
var SimpleStorage = artifacts.require("./SimpleStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(Betting);
  deployer.deploy(SimpleStorage);
};
