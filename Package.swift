// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GuilhermeabreudevCapacitorSystemSounds",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GuilhermeabreudevCapacitorSystemSounds",
            targets: ["SystemSoundsPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "SystemSoundsPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/SystemSoundsPlugin"),
        .testTarget(
            name: "SystemSoundsPluginTests",
            dependencies: ["SystemSoundsPlugin"],
            path: "ios/Tests/SystemSoundsPluginTests")
    ]
)