// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HyperSpace",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
          name: "HyperSpace",
          targets: ["HyperSpace"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/thecb4/Result.git", .upToNextMinor(from: "0.5.0"))
//      .package(url: "https://github.com/freshOS/then.git",  .upToNextMinor(from: "3.0.2"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "HyperSpace",
            dependencies: ["Result"],
            path: "Sources",
            sources:["HyperSpace/Core"]),
        .testTarget(
            name: "HyperSpaceUnitTests",
            dependencies: ["Result","HyperSpace"]),
    ]
)
