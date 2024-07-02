// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Step1",
            targets: ["Step1"]),
        .library(
            name: "Step2",
            targets: ["Step2"]),
        .library(
            name: "Step3",
            targets: ["Step3"]),
        .library(
            name: "Step4",
            targets: ["Step4"]),
    ],
    dependencies: [
      .package(url: "https://github.com/pointfreeco/swiftui-navigation", from: "1.5.0")
    ],
    targets: [
        .target(
            name: "Step1",
            dependencies: [.product(name: "SwiftUINavigation", package: "swiftui-navigation")]
        ),
        .target(
            name: "Step2",
            dependencies: [.product(name: "SwiftUINavigation", package: "swiftui-navigation")]
        ),
        .target(
            name: "Step3",
            dependencies: [.product(name: "SwiftUINavigation", package: "swiftui-navigation")]
        ),
        .target(
            name: "Step4",
            dependencies: [.product(name: "SwiftUINavigation", package: "swiftui-navigation")]
        ),
    ]
)
