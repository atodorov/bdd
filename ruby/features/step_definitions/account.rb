require 'banking'
require 'rspec/expectations'

Before do
    @accounts = {}
end

Given("{word} is an account owner") do |who|
    @accounts[who] = MyBank.new
end

Given("{word} has {int} kitty-coins") do |who, coins|
    @accounts[who].balance = coins
end


When("{word} wants to close their account") do |who|
    @last_owner = who
    expect { @accounts[who].close }.to raise_error(NotImplementedError)
end

Then("{word} account is still open") do |who|
    expect(@accounts.include?(who)).to be true
    expect(@accounts[who]).not_to be nil
end

When("{word} transfers {int} kitty-coins to {word}") do |sender, coins, receiver|
    @accounts[sender].transfer(coins, @accounts[receiver])
end

Then("{word} now owns {int} kitty-coins") do |who, coins|
    expect(@accounts[who].balance).to eq(coins)
end
