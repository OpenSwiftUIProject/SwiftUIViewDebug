// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIViewDebug",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .visionOS(.v1),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "SwiftUIViewDebug", targets: ["SwiftUIViewDebug"]),
    ],
    targets: [
        .target(
            name: "SwiftUIViewDebug"
        ),
    ]
)
