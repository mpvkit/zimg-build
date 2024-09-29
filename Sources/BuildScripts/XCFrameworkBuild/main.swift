import Foundation

do {
    let options = try ArgumentOptions.parse(CommandLine.arguments)
    try Build.performCommand(options)

    try BuildZimg().buildALL()
} catch {
    print("ERROR: \(error.localizedDescription)")
    exit(1)
}


enum Library: String, CaseIterable {
    case libzimg
    var version: String {
        switch self {
        case .libzimg:       // depend libunibreak libfreetype libfribidi libharfbuzz
            return "release-3.0.5"
        }
    }

    var url: String {
        switch self {
        case .libzimg:
            return "https://github.com/sekrit-twc/zimg"
        }
    }

    // for generate Package.swift
    var targets : [PackageTarget] {
        switch self {
        case .libzimg:
            return  [
                .target(
                    name: "libzimg",
                    url: "https://github.com/mpvkit/zimg-build/releases/download/\(BaseBuild.options.releaseVersion)/libzimg.xcframework.zip",
                    checksum: "https://github.com/mpvkit/zimg-build/releases/download/\(BaseBuild.options.releaseVersion)/libzimg.xcframework.checksum.txt"
                ),
            ]
        }
    }
}


private class BuildZimg: BaseBuild {
    init() {
        super.init(library: .libzimg)
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--enable-static",
            "--disable-shared",
            "--disable-fast-install",
            "--disable-dependency-tracking",
            "--host=\(platform.host(arch: arch))",
        ]
    }
}
