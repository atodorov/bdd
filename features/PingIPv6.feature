Feature: Ping IPv6
    https://fedoraproject.org/wiki/Changes/PingIpv6

    ping command should be able to work with both IPv6 and IPv4 addresses,
    eliminating the need for multiple tools.

    Background: Fedora 24
        Given the target release is Fedora 24


    Scenario: ping works for IPv4 addresses
        Given the user wants to ping an IPv4 address
         When they execute the command `ping 127.0.0.1`
         Then they should receive a reply.

    Scenario: ping works for IPv4 backed hostnames
        Given the user wants to ping a hostname backed by an IPv4 address
         When they execute the command `ping localhost`
         Then they should receive a reply.


    Scenario: ping works for IPv6 addresses
        Given the user wants to ping an IPv6 address
         When they execute the command `ping ::1`
         Then they should receive a reply.

    Scenario: ping works for IPv6 backed hostnames
        Given the user wants to ping a hostname backed by an IPv6 address
         When they execute the command `ping www.v6.facebook.com`
         Then they should receive a reply.
