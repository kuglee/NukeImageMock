// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "NukeImageMock",
  platforms: [
      .iOS(.v13),
      .tvOS(.v13),
      .macOS(.v10_15),
      .watchOS(.v6)
  ],
  products: [
    .library(name: "NukeImageMock", targets: ["NukeImageMock"]),
    .library(name: "NukeImagePipelineEnvironmentValue", targets: ["NukeImagePipelineEnvironmentValue"]),
  ],
  dependencies: [
    .package(url: "https://github.com/kean/Nuke", from: "12.2.0"),
  ],
  targets: [
    .target(
      name: "NukeImageMock",
      dependencies: [
        .product(name: "Nuke", package: "Nuke"),
      ]
    ),
    .target(
      name: "NukeImagePipelineEnvironmentValue",
      dependencies: [
        "NukeImageMock",
        .product(name: "Nuke", package: "Nuke"),
      ]
    ),
  ]
)
