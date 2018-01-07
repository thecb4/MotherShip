# Mothership

iTunes Connect Library inspired by [FastLane](https://github.com/fastlane/fastlane)

![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Build Status](https://travis-ci.org/thecb4/HyperSpace.svg?branch=master)](https://travis-ci.org/thecb4/HyperSpace)
![Platforms](https://img.shields.io/badge/platform-%20Linux%20|%20macOS%20-red.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

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
### To Do

- [ ] Documentation
- [ ] Ability to update app info
- [ ] Upload build
- [ ] Code signing? Or just leave it up to Apple
- [ ] Two-Factor Authentication?


### There is a Command Line Interface for MotherShip.

[MotherShip-CLI](https://github.com/thecb4/MotherShip-CLI)

```zsh
$ mothership login <user> <password>
$ mothership testflight invite <email> <first-name> <last-name> <app-id> <team-id>
```
