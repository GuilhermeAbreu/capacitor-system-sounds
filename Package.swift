// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GuilhermeabreudevCapacitorSystemSounds",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GuilhermeabreudevCapacitorSystemSounds",
            targets: ["CapacitorSystemSoundsPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CapacitorSystemSoundsPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapacitorSystemSoundsPlugin"),
        .testTarget(
            name: "CapacitorSystemSoundsPluginTests",
            dependencies: ["CapacitorSystemSoundsPlugin"],
            path: "ios/Tests/CapacitorSystemSoundsPluginTests")
    ]
)