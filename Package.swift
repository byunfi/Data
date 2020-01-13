// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v12), .macOS(.v10_12)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0-beta.6")),
        .package(url: "git@github.com:ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "git@github.com:tid-kijyun/Kanna.git", .upToNextMajor(from: "5.0.0")),
        .package(path: "~/Workspace/Xcode Projects/Chaldea/Domain"),
        .package(url: "https://github.com/groue/GRDB.swift.git", .upToNextMajor(from: "4.7.0")),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: ["Moya", "RxSwift", "Kanna", "Domain", "GRDB"]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "RxTest", "RxBlocking"]
        ),
    ]
)
