Feature: kitty-coin transfer

    Given Alex is an account owner
    And he has 100 kitty-coins
    And Jane is an account owner
    And she has 50 kitty-coins
    When Alex transfers 20 kitty-coins to Jane
    Then Alex now owns 80 kitty-coins
    And  Jane now owns 70 kitty-coins
