class MyBank
    attr_accessor :balance

    def initialize
        @balance = 0
    end

    def close
        raise NotImplementedError.new('This is not possible per specification')
    end

    def transfer(coins, to_whom)
        @balance -= coins
        to_whom.balance += coins
    end
end
