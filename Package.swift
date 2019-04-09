// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Aiger",
    products: [
        .library(name: "Aiger", targets: ["Aiger"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ltentrup/CAiger.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "Aiger", dependencies: ["CAiger"]),
        .testTarget(name: "AigerTests", dependencies: ["Aiger"]),
    ]
)
