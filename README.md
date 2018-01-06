# Mothership

iTunes Connect Library inspired by [FastLane](https://github.com/fastlane/fastlane)

I wrote MotherShip for two reasons.
1.  love FastLane, but I am not proficient in [Ruby](https://www.ruby-lang.org/en/).
2. I wanted to see how difficult it would be to write a port.

## What can MotherShip do?
1. Login to iTunesConnect
2. Get list of Testers
3. Get list of Groups
4. Invite someone to test an app

```swift

import MotherShip

let firstName = "C"
let lastName  = "B"
let email     = "info@thecb4.io"


let tester = Tester(email: email, firstName: firstName, lastName: lastName)

let testFlight = TestFlight()

testFlight.login(with: creds)

let code = testFlight.invite(tester: tester, to: appInfo.appIdentifier, for: appInfo.teamIdentifier)

```

