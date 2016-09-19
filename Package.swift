import PackageDescription

let package = Package(
    name: "Aiger",
    dependencies: [
        .Package(url: "../CAiger", majorVersion: 0, minor: 1)
    ]
)
