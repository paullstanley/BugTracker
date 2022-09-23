// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "macOS-ApplicationLogic",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "macOS-ApplicationLogic",
            targets: ["macOS-ApplicationLogic"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "UseCases", path: "../UseCases"),
        .package(name: "CoreDataPlugin", path: "../CoreDataPlugin")
    ],
    targets: [
        .target(
            name: "macOS-ApplicationLogic",
            dependencies: [
                "Domain",
                "UseCases",
                "CoreDataPlugin"
            ]),
        .testTarget(
            name: "macOS-ApplicationLogicTests",
            dependencies: ["macOS-ApplicationLogic"]),
    ]
)
