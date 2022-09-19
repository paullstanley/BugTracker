// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreDataPlugin",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "CoreDataPlugin",
            targets: ["CoreDataPlugin"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "UseCases", path: "../UseCases")
    ],
    targets: [
        .target(
            name: "CoreDataPlugin",
            dependencies: [
                "Domain",
                "UseCases"
            ],
            resources:[
                .copy("CoreDataXC/IssueTrackingSystem.xcdatamodeld")
            ]),
        .testTarget(
            name: "CoreDataPluginTests",
            dependencies: ["CoreDataPlugin"]),
    ]
)
