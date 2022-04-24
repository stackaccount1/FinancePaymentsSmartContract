# @version ^0.2.0
# Objects 
bank: public(address)
mortgagor: public(address)
mortgageStart: public(uint256)
principle: public(uint256)
interestRate: public(uint256)
paymentAmount: public(uint256)
paymentsMade : public(uint256)
interestportion : public(uint256)
towardprinciple : public(uint256)

#Events
event Payment:
    paymentAmount : uint256
    paymentMade : uint256

event Principlepaid:
    sender : indexed(address)
    value : uint256
    
event Withdrawal:
    value : uint256

#Funtions
@external
def __init__(_principle:uint256, _interestRate: uint256, _paymentAmount: uint256):
    self.bank = msg.sender
    self.principle = _principle
    self.interestRate = _interestRate
    self.mortgageStart = block.timestamp
    self.paymentAmount = _paymentAmount
    self.paymentsMade = 0

# Monthly Payment 
@external
@payable
def makePayment():
    assert msg.value == self.paymentAmount, "Payment must match payment amount, to pay principle directly use payPrinciple function at any amount"
    #take interest portion of the payment
    self.interestportion = self.principle * (self.interestRate/12)
    #return the remaining portion to reduce the prinicple balance
    self.towardprinciple = msg.value - self.interestportion
    self.principle = self.principle - self.towardprinciple
    self.paymentsMade = self.paymentsMade + 1
    self.interestportion = 0
    self.towardprinciple = 0
    log Payment(msg.value, self.paymentsMade)

# Make Unscheduled Principle Payment 
@external
@payable
def payPrinciple():
    assert msg.value > 0, "must be greater than 0"
    self.principle = self.principle - msg.value
    log Principlepaid(msg.sender, msg.value)

@external
def returnprinciple() -> uint256:
    return self.principle

# Bank withdraw payment from mortgage 
@external
def withdrawBalance():
    send(self.bank, self.balance)
    log Withdrawal(self.balance)


#send NFT as deed on self destruct
