// beak: JohnSundell/ShellOut @ 2.1.0

import Foundation
import ShellOut

let project = "MotherShip"

public enum Platform: String {
  case all
  case macOS
  case iOS
  case watchOS
  case tvOS
}

public enum Cleanable: String {
  case xcode
  case carthage
}

var platform: Platform = .macOS

public enum PlatformDestination: String {
  case macOS_Simulator   = "\"platform=OS X\""
  case iOS_Simulator     = "\"platform=iOS Simulator,name=iPhone 8\""
  case watchOS_Simulator = "\"platform=watchOS Simulator,name=Apple Watch - 38mm\""
  case tvOS_Simulator    = "\"platform=tvOS Simulator,name=Apple TV\""
}

let destinations: [ Platform : PlatformDestination ] = [
  .macOS:   .macOS_Simulator,
  .iOS:     .iOS_Simulator,
  .watchOS: .watchOS_Simulator,
  .tvOS:    .tvOS_Simulator
]

/**
 Dummy
*/
public func setup_homebrew() throws {

  let actions = [
    "brew update",
    "brew outdated carthage || brew upgrade carthage",
    "brew outdated mint || brew upgrade mint",
    "brew tap yonaskolb/Beak https://github.com/yonaskolb/Beak.git",
    "brew install Beak"
  ]

}

/**
 Removed XCode Project Data

 - Parameters:
  - files: files to be cleaned

*/
public func clean(files: Cleanable) throws {
    // implementation here

    print("cleaning \(files)")

    switch files {
      case .xcode:
        let _ = try shellOut(to: "rm -rf DerivedData")
        print("cleaned")
      case .carthage:
        let _ = try shellOut(to: "rm -rf Carthage")
        print("cleaned")
    }
}

/**
 Build Carthage dependencies

 - Parameters:
  - platform: platform to build Carthage dependencies for (.macOS, .iOS, .tvOS, .watchOS, , .all)

*/
public func build_carthage_dependencies(platform: Platform = .all) throws {

  print("building carthage dependencies for \(platform)")

  switch platform {
    case .macOS, .iOS, .watchOS, .tvOS:
      let output = try shellOut(to: "carthage bootstrap --platform \(platform)")
      print(output)
    case .all:
      let output = try shellOut(to: "carthage bootstrap")
      print(output)
  }

}

/**
 Build XCode Project

 - Parameters:
  - platform: platform to build XCode for (.macOS, .iOS, .tvOS, .watchOS, , .all)

*/
public func xcode_build(platform: Platform) throws {
  switch platform {
    case .macOS, .iOS, .watchOS, .tvOS:
      let action = "xcodebuild clean build -project \(project).xcodeproj -scheme \(project)-\(platform) -quiet"
      let output = try shellOut(to: action)
      print(output)
    case .all:
      print("must chose a platform: macOS | iOS | watchOS | tvOS")
  }
}

/**
 Test XCode Project

 - Parameters:
  - platform: platform to build Carthage dependencies for (.macOS, .iOS, .tvOS, .watchOS, , .all)

*/
public func xcode_test(platform: Platform) throws {
  switch platform {
    case .macOS:
      guard let destination = destinations[platform] else { fatalError() }
      let action = "set -o pipefail && xcodebuild test -project \(project).xcodeproj -scheme \(project)-\(platform) -destination \(destination.rawValue) | xcpretty"
      let output = try shellOut(to: action)
      print(output)
    case .iOS, .tvOS:
      guard let destination = destinations[platform] else { fatalError() }
      let action = "set -o pipefail && xcodebuild test -project \(project).xcodeproj -scheme \(project)-\(platform) -destination \(destination.rawValue) -enableCodeCoverage YES | xcpretty"
      let output = try shellOut(to: action)
      print(output)
    case .watchOS:
      print("cannot test watchOS... complain to Apple")
    case .all:
      print("must chose a platform: macOS | iOS | watchOS | tvOS")
  }
}


/**
 Installs the product
*/
public func install() throws {
    // implementation here
    print("installed")
}

/**
 Deletes the product
*/
public func delete() throws {
    // implementation here
    print("deleted")
}
