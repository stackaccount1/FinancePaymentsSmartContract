from brownie import mortgagecontract, network, config, accounts
from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)

def deploy_md():
    account = accounts.add(config["wallets"]["from_key"])
    #account = get_account()
    account.deploy(mortgagecontract)
    print(account)
    return(mortgagecontract)

def main():
    deploy_md()
