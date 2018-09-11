const MewToken = artifacts.require('./MewToken');
const MewTokenWhitelist = artifacts.require('./MewTokenWhitelist');
const MewTokenSale = artifacts.require('./MewTokenSale');

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(MewToken).then(function() {
    deployer.deploy(MewTokenWhitelist).then(function() {
      deployer.deploy(MewTokenSale, MewToken.address, MewTokenWhitelist.address);
    });
  });
};
