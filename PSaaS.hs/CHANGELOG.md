# Revision history for PSaaS-hs

## 0.3.0.0

* More type safety (`Data.List.Infinite`, `Data.List.NonEmpty`, `Data.Text,NonEmpty`)
* Total chars is configuratable (defaults to 4000)
* Streaming responses
  * Achieved 70MiB/s on localhost without breaking 25MiB res mem
  * For 4 concurrent requests, 45MiB/s and 70MiB (i.e. sublinear drop-off)

## 0.2.0.0

* Nobody knows.

## 0.1.0.0

* First version. Released on an unsuspecting world.
