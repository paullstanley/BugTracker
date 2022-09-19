// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UseCases",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "UseCases",
            targets: ["UseCases"]),
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "UseCases",
            dependencies: ["Domain"]),
        .testTarget(
            name: "UseCasesTests",
            dependencies: ["UseCases"]),
    ]
)
