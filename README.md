# Mothership

iTunes Connect Library inspired by [FastLane](https://github.com/fastlane/fastlane)

[![version](https://img.shields.io/badge/version-0.4.1-green.svg)](https://github.com/thecb4/MotherShip/tree/0.5.1)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Build Status](https://travis-ci.org/thecb4/HyperSpace.svg?branch=master)](https://travis-ci.org/thecb4/MotherShip)
![Platforms](https://img.shields.io/badge/platform-%20Linux%20|%20macOS%20|%20iOS%20|%20tvOS%20|%20watchOS%20-red.svg)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

I wrote MotherShip for two reasons.
1.  love FastLane, but I am not proficient in [Ruby](https://www.ruby-lang.org/en/).
2. I wanted to see how difficult it would be to write a port.

## What can MotherShip do?
1. Login to iTunesConnect
2. Get list of Testers
3. Get list of Groups
4. Get list of Versions
5. Get list of Builds
6. Get App level Test Info
7. Invite someone to test an app
8. Update App level Test Information!
9. Get Build Details
10. Update Build Test Info

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
- [x ] Ability to update app info
- [ ] Upload build
- [ ] Code signing? Or just leave it up to Apple
- [ ] Two-Factor Authentication?

### There is a Command Line Interface for MotherShip.

[MotherShip-CLI](https://github.com/thecb4/MotherShip-CLI)

```zsh
$ mothership login <user> <password>
$ mothership testflight invite <email> <first-name> <last-name> <app-id> <team-id>
```
