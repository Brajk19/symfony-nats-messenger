Feature: NKey authentication
  Tests a transport that authenticates with an NKey seed and no user or
  password. The NATS server knows the user only by its public key and
  checks a signature of its nonce. Verification: the stream is set up,
  and messages are sent and consumed over connections authenticated
  that way.

  Background:
    Given NATS server is running

  @nkey
  Scenario: Messages are sent and consumed by a user that authenticates with an NKey seed
    Given I have a messenger transport configured with an NKey seed
    And the NATS stream is set up
    And the test files directory is clean
    When I send 5 messages to the transport
    Then the messenger stats should show 5 messages waiting
    When I start a messenger consumer
    And I wait for messages to be consumed
    Then all 5 messages should be consumed
