import PackageDescription

let package = Package(
    name: "Aiger",
    dependencies: [
        .Package(url: "https://github.com/ltentrup/CAiger.git", majorVersion: 0, minor: 1)
    ]
)
