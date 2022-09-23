// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOS-ApplicationLogic",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "iOS-ApplicationLogic",
            targets: ["iOS-ApplicationLogic"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "UseCases", path: "../UseCases"),
        .package(name: "CoreDataPlugin", path: "../CoreDataPlugin")
    ],
    targets: [
        .target(
            name: "iOS-ApplicationLogic",
            dependencies: [
                "Domain",
                "UseCases",
                "CoreDataPlugin"
            ]),
        .testTarget(
            name: "iOS-ApplicationLogicTests",
            dependencies: ["iOS-ApplicationLogic"]),
    ]
)
