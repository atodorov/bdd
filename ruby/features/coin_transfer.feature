Feature: kitty-coin transfer

    Scenario: Transfering kitty-coins to another user
        Given Alex is an account owner
        And Alex has 100 kitty-coins
        And Jane is an account owner
        And Jane has 50 kitty-coins
        When Alex transfers 20 kitty-coins to Jane
        Then Alex now owns 80 kitty-coins
        And  Jane now owns 70 kitty-coins
