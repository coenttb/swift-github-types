// swift-tools-version: 6.0

import PackageDescription

extension String {
    static let githubTypes: Self = "GitHub Types"
    static let githubTrafficTypes: Self = "GitHub Traffic Types"
    static let githubRepositoriesTypes: Self = "GitHub Repositories Types"
    static let githubStargazersTypes: Self = "GitHub Stargazers Types"
    static let githubIssuesTypes: Self = "GitHub Issues Types"
    static let githubPullRequestsTypes: Self = "GitHub Pull Requests Types"
    static let githubActionsTypes: Self = "GitHub Actions Types"
    static let githubUsersTypes: Self = "GitHub Users Types"
    static let githubOrganizationsTypes: Self = "GitHub Organizations Types"
    static let githubWebhooksTypes: Self = "GitHub Webhooks Types"
    static let githubTypesShared: Self = "GitHub Types Shared"
}

extension Target.Dependency {
    static var githubTypes: Self { .target(name: .githubTypes) }
    static var githubTrafficTypes: Self { .target(name: .githubTrafficTypes) }
    static var githubRepositoriesTypes: Self { .target(name: .githubRepositoriesTypes) }
    static var githubStargazersTypes: Self { .target(name: .githubStargazersTypes) }
    static var githubIssuesTypes: Self { .target(name: .githubIssuesTypes) }
    static var githubPullRequestsTypes: Self { .target(name: .githubPullRequestsTypes) }
    static var githubActionsTypes: Self { .target(name: .githubActionsTypes) }
    static var githubUsersTypes: Self { .target(name: .githubUsersTypes) }
    static var githubOrganizationsTypes: Self { .target(name: .githubOrganizationsTypes) }
    static var githubWebhooksTypes: Self { .target(name: .githubWebhooksTypes) }
    static var githubTypesShared: Self { .target(name: .githubTypesShared) }
}

extension Target.Dependency {
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var tagged: Self { .product(name: "Tagged", package: "swift-tagged") }
    static var typesFoundation: Self { .product(name: "TypesFoundation", package: "swift-types-foundation") }
}

let package = Package(
    name: "swift-github-types",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: .githubTypes, targets: [.githubTypes]),
        .library(name: .githubTrafficTypes, targets: [.githubTrafficTypes]),
        .library(name: .githubRepositoriesTypes, targets: [.githubRepositoriesTypes]),
        .library(name: .githubStargazersTypes, targets: [.githubStargazersTypes]),
        .library(name: .githubTypesShared, targets: [.githubTypesShared])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.9.2"),
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.10.0"),
        .package(url: "https://github.com/coenttb/swift-types-foundation", from: "0.0.1")
    ],
    targets: [
        .target(
            name: .githubTypesShared,
            dependencies: [
                .typesFoundation,
                .dependenciesMacros,
                .tagged
            ]
        ),
        .target(
            name: .githubTypes,
            dependencies: [
                .typesFoundation,
                .githubTypesShared,
                .githubTrafficTypes,
                .githubRepositoriesTypes,
                .githubStargazersTypes,
                .dependenciesMacros
            ]
        ),
        .target(
            name: .githubTrafficTypes,
            dependencies: [
                .typesFoundation,
                .githubTypesShared,
                .dependenciesMacros,
                .tagged
            ]
        ),
        .target(
            name: .githubRepositoriesTypes,
            dependencies: [
                .typesFoundation,
                .githubTypesShared,
                .dependenciesMacros,
                .tagged
            ]
        ),
        .target(
            name: .githubStargazersTypes,
            dependencies: [
                .typesFoundation,
                .githubTypesShared,
                .dependenciesMacros,
                .tagged
            ]
        ),
        .testTarget(
            name: "GitHub Types Tests",
            dependencies: [.githubTypes]
        ),
        .testTarget(
            name: "GitHub Traffic Types Tests",
            dependencies: [.githubTrafficTypes]
        ),
        .testTarget(
            name: "GitHub Repositories Types Tests",
            dependencies: [.githubRepositoriesTypes]
        )
    ],
    swiftLanguageModes: [.v6]
)
