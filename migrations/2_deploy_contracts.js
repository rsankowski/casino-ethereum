var Casino = artifacts.require("./Casino.sol");

module.exports = function(deployer) {
deployer.deploy(web3.toWei(0.1, 'ether'), 100, {gas: 300000}); //0.1 is the minimumBet, 100 is the max amount of players and 300k is the gas limit to deploy the contract
};
