// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Slidoo",
    platforms: [
        .macOS(.v14)
    ],
    targets: [
        .executableTarget(
            name: "Slidoo",
            path: "Sources/Slidoo"
        )
    ]
)
