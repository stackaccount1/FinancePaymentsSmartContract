from brownie import mortgagecontract, network, config, accounts
from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)

def deploy_md():
    account = accounts.add(config["wallets"]["from_key"])
    #account = get_account()
    deploycontract = mortgagecontract.deploy(900_000_000_000_000_000_000, 30_000_000_000_000_000, 1_000_000_000_000_000_000, {"from" : account})
    print(account)
    return(deploycontract)

def main():
    deploy_md()

#0x14a5C3a2FBeEc611Bc17f70865176a56B6B7B7A7
#deployed address