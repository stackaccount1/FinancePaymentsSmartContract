# @version ^0.2.0
greeting: public(String[100])

@external
def __init__():
    self.greeting = "helloworld"
@view
@external
def returnGreeting() -> (String[100]):
    return self.greeting

@external
def setGreeting(_newgreeting: String[100]):
    self.greeting = _newgreeting