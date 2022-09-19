// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Application",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "Application",
            targets: ["Application"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "UseCases", path: "../UseCases"),
        .package(name: "CoreDataPlugin", path: "../CoreDataPlugin")
    ],
    targets: [
        .target(
            name: "Application",
            dependencies: [
                "Domain",
                "UseCases",
                "CoreDataPlugin"
            ]),
        .testTarget(
            name: "ApplicationTests",
            dependencies: ["Application"]),
    ]
)
