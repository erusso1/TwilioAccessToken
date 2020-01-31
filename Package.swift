// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "TwilioAccessToken",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "TwilioAccessToken",
            targets: ["TwilioAccessToken"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/service.git", from: "1.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "TwilioAccessToken",
            dependencies: ["Service", "JWT"],
            path: "Sources"
        ),
        .testTarget(
            name: "TwilioAccessTokenTests",
            dependencies: ["TwilioAccessToken"]),
    ]
)
