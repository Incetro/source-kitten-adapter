// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "source-kitten-adapter",
    products: [
        .library(
            name: "SourceKittenAdapter",
            targets: [
                "source-kitten-adapter"
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "Files",
            url: "https://github.com/johnsundell/files.git",
            from: "4.1.1"
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "0.2.0"
        ),
        .package(
            name: "ShellOut",
            url: "https://github.com/JohnSundell/ShellOut.git",
            from: "2.0.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "source-kitten-adapter",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                ),
                .product(
                    name: "ShellOut",
                    package: "ShellOut"
                ),
                .product(
                    name: "Files",
                    package: "Files"
                )
            ]
        ),
        .testTarget(
            name: "source-kitten-adapterTests",
            dependencies: [
                "source-kitten-adapter"
            ]
        ),
    ]
)
