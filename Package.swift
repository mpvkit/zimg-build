// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libzimg",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "libzimg",
            targets: ["_Libzimg"]
        ),
    ],
    targets: [
        // Need a dummy target to embedded correctly.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(
            name: "_Libzimg",
            dependencies: ["Libzimg"],
            path: "Sources/_Dummy"
        ),
        //AUTO_GENERATE_TARGETS_BEGIN//

        .binaryTarget(
            name: "libzimg",
            url: "https://github.com/mpvkit/zimg-build/releases/download/3.0.5/libzimg.xcframework.zip",
            checksum: "e68458c0b94377920d388283a207fef9dbd626b339df7124722b985d353cc695"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)
