require 'banking'
require 'rspec/expectations'

@accounts = {}

Given("{string} is an account owner") do |who|
    @accounts[who] = MyBank.new
end

Given("{string} has {int} kitty-coins") do |who, coins|
    @accounts[who].balance = coins
end


When("{string} wants to close their account") do |who|
    @accounts[who].close
end

Then("closing an account is not possible") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("{string} transfers {float} kitty-coins to {string}") do |sender, coins, receiver|
    @accounts[sender].transfer(coins, @accounts[receiver])
end

Then("{string} now owns {float} kitty-coins") do |who, coins|
    expect(@accounts[who].balance).to eq(coins)
end
