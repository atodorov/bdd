Feature: Closing account

    per specification this is not possible

    Scenario: Closing account is not possible
        Given Alex is an account owner
        When Alex wants to close their account
        Then closing an account is not possible
