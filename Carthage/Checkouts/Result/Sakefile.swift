// https://github.com/xcodeswift/sake

import Foundation
import SakefileDescription

let project = "Result"

enum Platform: String {
  case macOS
  case iOS
  case watchOS
  case tvOS
}

var platform: Platform = .macOS

enum PlatformDestination: String {
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

let sake = Sake(tasks: [
    Task("xcodegen-clean", description: "Removed XCode Project Data") {
        // Here is where you define your build task
        try Utils.shell.runAndPrint(bash: "rm -rf HyperSpace.xcodreproj")
        try Utils.shell.runAndPrint(bash: "rm -rf DerivedData")
    },
    Task("xcodegen", description: "Generate XCode Project Data") {
        // Here is where you define your build task
        try Utils.shell.runAndPrint(bash: "xcodegen")
    },
    Task("carthage-clean", description: "Cleans Project Carthage Dependencies") {
        // Here is where you define your build task
        try Utils.shell.runAndPrint(bash: "rm -rf Cartfile.resolved")
        try Utils.shell.runAndPrint(bash: "rm -rf Carthage")
    },
    Task("carthage-build-platform-dependencies", description: "Builds project Carthage dependencies for platform") {
        // Here is where you define your build task
        try Utils.shell.runAndPrint(bash: "carthage bootstrap --platform \(platform)")
        // try Utils.shell.runAndPrint(bash: carthageBuild)
    },
    Task("xcode-build-platform", description: "Build specific platform with XCode") {
        // Here is where you define your build task
        let action = "xcodebuild clean build -project \(project).xcodeproj -scheme \(project)-\(platform) -quiet"
        try Utils.shell.runAndPrint(bash: action)
    },
    Task("xcode-test-platform", description: "Test specific platform with XCode. XCPretty output.") {
        // Here is where you define your build task
        guard let destination = destinations[platform] else { fatalError() }
        print("destination = \(destination.rawValue)")
        switch platform {
        case .macOS:
          let action = "set -o pipefail && xcodebuild test -project \(project).xcodeproj -scheme \(project)-\(platform) -destination \(destination.rawValue) | xcpretty"
          try Utils.shell.runAndPrint(bash: action)
        case .iOS,.tvOS:
          let action = "set -o pipefail && xcodebuild test -project \(project).xcodeproj -scheme \(project)-\(platform) -destination \(destination.rawValue) -enableCodeCoverage YES | xcpretty"
          try Utils.shell.runAndPrint(bash: action)
        case .watchOS:
          ()
        }

    },

  ],


    hooks: [
        .beforeAll({
        /* Before all the tasks */
        do {
          let platformString = try Utils.shell.run(bash: "echo $PLATFORM")
          print("platform string = \(platformString)")
          guard let _platform = Platform(rawValue: platformString) else { fatalError() }
          print("_platform = \(_platform)")
          platform = _platform
          print("platform = \(platform)")
        } catch {

        }

      })
    ]
)
