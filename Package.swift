// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Swiftgres",
    products: [
        .library(
            name: "Swiftgres",
            targets: ["Swiftgres"]),
    ],
    dependencies: [
        // Necessary until we get test-only dependencies :)
        .package(url: "https://github.com/PerfectlySoft/Perfect-libpq.git", from: "2.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Swiftgres",
            dependencies: []),
        .testTarget(
            name: "SwiftgresTests",
            dependencies: [
                "Swiftgres",
            ]),
        .testTarget(
            name: "SwiftgresIntegrationTests",
            dependencies: [
                "Swiftgres",
            ])
    ]
)

