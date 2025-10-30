# swift-github-types

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.1.0-green.svg)](https://github.com/coenttb/swift-github-types/releases)
[![CI](https://github.com/coenttb/swift-github-types/workflows/CI/badge.svg)](https://github.com/coenttb/swift-github-types/actions/workflows/ci.yml)

Type-safe Swift definitions for GitHub's REST API with dependency injection support.

## Overview

`swift-github-types` provides comprehensive type definitions for GitHub's REST API, including:

- 📊 **Traffic Analytics**: Repository views, clones, paths, and referrers
- ⭐ **Stargazers**: Star tracking with timestamps
- 📦 **Repositories**: Full repository management (create, read, update, delete, list)
- 👥 **Collaborators**: Repository collaboration and permissions
- 🔐 **OAuth**: GitHub OAuth flow types
- 🎯 **Type Safety**: Strongly-typed models with Codable conformance
- 🔌 **Dependency Injection**: Using swift-dependencies for testability

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-github-types", from: "0.1.0")
]
```

## Quick Start

### Import Modules

```swift
import GitHub_Types
import GitHub_Traffic_Types
import GitHub_Repositories_Types
import GitHub_Stargazers_Types
```

### Using Type-Safe Models

```swift
// Traffic analytics response
let viewsResponse: GitHub.Traffic.Views.Response
print("Total views: \(viewsResponse.count)")
print("Unique visitors: \(viewsResponse.uniques)")

// Repository model
let repository: GitHub.Repository
print("Repository: \(repository.fullName)")
print("Stars: \(repository.stargazersCount)")

// Stargazers list response
let stargazers: GitHub.Stargazers.List.Response  // Array of Stargazer
for stargazer in stargazers {
    print("\(stargazer.user.login) starred at \(stargazer.starredAt)")
}
```

## Usage Examples

### Repositories

#### List User Repositories

```swift
import GitHub_Repositories_Types

// Create list request with filtering
let listRequest = GitHub.Repositories.List.Request(
    visibility: .public,
    type: .owner,
    sort: .updated,
    direction: .desc,
    perPage: 30,
    page: 1
)

// Use with a client implementation
let repositories = try await repositoriesClient.list(listRequest)
// Returns: [GitHub.Repository]
```

#### Create a Repository

```swift
let createRequest = GitHub.Repositories.Create.Request(
    name: "my-new-repo",
    description: "A Swift package for awesome things",
    private: false,
    hasIssues: true,
    hasWiki: true,
    autoInit: true,
    gitignoreTemplate: "Swift",
    licenseTemplate: "apache-2.0"
)

let repository = try await repositoriesClient.create(createRequest)
// Returns: GitHub.Repository
```

#### Get Repository Details

```swift
let repository = try await repositoriesClient.get(
    owner: "coenttb",
    repo: "swift-github-types"
)
// Returns: GitHub.Repository
```

#### Update Repository Settings

```swift
let updateRequest = GitHub.Repositories.Update.Request(
    description: "Updated description",
    private: true,
    hasIssues: true,
    defaultBranch: "main"
)

let updated = try await repositoriesClient.update(
    owner: "coenttb",
    repo: "my-repo",
    request: updateRequest
)
// Returns: GitHub.Repository
```

#### Delete a Repository

```swift
let response = try await repositoriesClient.delete(
    owner: "coenttb",
    repo: "old-repo"
)
// Returns: GitHub.Repositories.Delete.Response
```

### Traffic Analytics

#### Get Repository Views

```swift
import GitHub_Traffic_Types

let viewsResponse = try await trafficClient.views(
    owner: "coenttb",
    repo: "swift-github-types",
    per: .day
)

print("Total views: \(viewsResponse.count)")
print("Unique visitors: \(viewsResponse.uniques)")

for view in viewsResponse.views {
    print("Date: \(view.timestamp), Views: \(view.count)")
}
```

#### Get Clone Statistics

```swift
let clonesResponse = try await trafficClient.clones(
    owner: "coenttb",
    repo: "swift-github-types",
    per: .week
)

print("Total clones: \(clonesResponse.count)")
print("Unique cloners: \(clonesResponse.uniques)")
```

#### Get Top Referral Paths

```swift
let pathsResponse = try await trafficClient.paths(
    owner: "coenttb",
    repo: "swift-github-types"
)

for path in pathsResponse.paths {
    print("\(path.path): \(path.count) views")
}
```

#### Get Top Referral Sources

```swift
let referrersResponse = try await trafficClient.referrers(
    owner: "coenttb",
    repo: "swift-github-types"
)

for referrer in referrersResponse.referrers {
    print("\(referrer.referrer): \(referrer.count) views")
}
```

### Stargazers

```swift
import GitHub_Stargazers_Types

let request = GitHub.Stargazers.List.Request(
    perPage: 100,
    page: 1
)

let stargazers = try await stargazersClient.list(
    owner: "coenttb",
    repo: "swift-github-types",
    request: request
)

for stargazer in stargazers {
    print("\(stargazer.user.login) starred on \(stargazer.starredAt)")
}
```

## Architecture

The package is organized into modular components:

- **GitHub_Types_Shared**: Common types (Repository, Owner, License, User, Timestamp)
- **GitHub_Traffic_Types**: Traffic analytics types and client protocol
- **GitHub_Repositories_Types**: Repository management types and client protocol
- **GitHub_Stargazers_Types**: Stargazer types and client protocol
- **GitHub_Collaborators_Types**: Collaboration types and client protocol
- **GitHub_OAuth_Types**: OAuth flow types and client protocol
- **GitHub_Types**: Umbrella client combining all feature modules

### Type Organization

Each module follows a consistent pattern:

```swift
// GitHub namespace contains all feature modules
extension GitHub {
    public enum Repositories: Sendable {}  // Repository feature namespace
    public enum Traffic: Sendable {}       // Traffic feature namespace
}

// Request/Response types are nested under operation namespaces
extension GitHub.Repositories {
    public enum List {}
    public enum Create {}
    public enum Update {}
}

extension GitHub.Repositories.List {
    public struct Request: Codable, Equatable, Sendable { /* ... */ }
    public typealias Response = [GitHub.Repository]
}
```

### Client Structure

```swift
// Feature-specific clients
extension GitHub.Repositories {
    @DependencyClient
    public struct Client: Sendable {
        public var list: @Sendable (_ request: List.Request?) async throws -> List.Response
        public var get: @Sendable (_ owner: String, _ repo: String) async throws -> GitHub.Repository
        public var create: @Sendable (_ request: Create.Request) async throws -> GitHub.Repository
        public var update: @Sendable (_ owner: String, _ repo: String, _ request: Update.Request) async throws -> GitHub.Repository
        public var delete: @Sendable (_ owner: String, _ repo: String) async throws -> Delete.Response
    }
}

// Main GitHub client combining all features
extension GitHub {
    @DependencyClient
    public struct Client: Sendable {
        public var traffic: Traffic.Client
        public var repositories: Repositories.Client
        public var stargazers: Stargazers.Client
        public var oauth: OAuth.Client
        public var collaborators: Collaborators.Client
    }
}
```

## Testing

Create mock clients for testing using swift-dependencies:

```swift
import GitHub_Types
import GitHub_Repositories_Types
import Dependencies
import Testing

@Test func testRepositoryListing() async throws {
    // Create mock repository data
    let mockRepo = GitHub.Repository(
        id: .init(rawValue: 123),
        nodeId: "MDEwOlJlcG9zaXRvcnkxMjM=",
        name: "test-repo",
        fullName: "user/test-repo",
        private: false,
        owner: GitHub.Owner(
            id: .init(rawValue: 456),
            login: "user",
            nodeId: "MDQ6VXNlcjQ1Ng==",
            avatarUrl: URL(string: "https://github.com/avatar")!,
            gravatarId: "",
            url: URL(string: "https://api.github.com/users/user")!,
            htmlUrl: URL(string: "https://github.com/user")!,
            type: "User",
            siteAdmin: false
        ),
        htmlUrl: URL(string: "https://github.com/user/test-repo")!,
        description: "Test repository",
        fork: false,
        url: URL(string: "https://api.github.com/repos/user/test-repo")!,
        createdAt: Date(),
        updatedAt: Date(),
        pushedAt: Date(),
        size: 100,
        stargazersCount: 5,
        watchersCount: 3,
        language: "Swift",
        hasIssues: true,
        hasProjects: true,
        hasDownloads: true,
        hasWiki: true,
        hasPages: false,
        forksCount: 2,
        archived: false,
        disabled: false,
        openIssuesCount: 1,
        license: nil,
        allowForking: true,
        isTemplate: false,
        topics: ["swift", "testing"],
        visibility: "public",
        defaultBranch: "main"
    )

    // Create mock client
    let client = GitHub.Repositories.Client(
        list: { request in
            #expect(request?.type == .owner)
            return [mockRepo]
        },
        get: { owner, repo in
            #expect(owner == "user")
            #expect(repo == "test-repo")
            return mockRepo
        },
        create: { request in
            #expect(request.name == "new-repo")
            return mockRepo
        },
        update: { owner, repo, request in
            return mockRepo
        },
        delete: { owner, repo in
            return GitHub.Repositories.Delete.Response(
                message: "Repository deleted",
                documentationUrl: nil
            )
        }
    )

    // Test list operation
    let repos = try await client.list(GitHub.Repositories.List.Request(type: .owner))
    #expect(repos.count == 1)
    #expect(repos[0].name == "test-repo")

    // Test get operation
    let repo = try await client.get(owner: "user", repo: "test-repo")
    #expect(repo.fullName == "user/test-repo")
}
```

## API Routes

Each client has a corresponding API router for URL construction:

```swift
import GitHub_Repositories_Types

let router = GitHub.Repositories.API.Router()

// Generate URLs for API endpoints
let listAPI = GitHub.Repositories.API.list(request: nil)
let listURL = router.url(for: listAPI)
// Result: /user/repos

let getAPI = GitHub.Repositories.API.get(owner: "coenttb", repo: "swift-github-types")
let getURL = router.url(for: getAPI)
// Result: /repos/coenttb/swift-github-types
```

## Features

### Traffic Analytics
- Repository view counts and unique visitors (daily/weekly breakdown)
- Clone statistics with unique cloners (daily/weekly breakdown)
- Top referral paths with view counts
- Top referral sources with traffic data

### Repository Management
- List repositories with filtering (visibility, type, affiliation)
- Get repository details with full metadata
- Create repositories with templates and configuration
- Update repository settings
- Delete repositories

### Stargazers
- List stargazers with pagination
- Stargazer timestamps for analytics
- User information for each stargazer

### Collaborators
- List repository collaborators
- Check collaborator status
- Add/remove collaborators
- Manage repository permissions
- Handle collaboration invitations

## Related Packages

- [swift-github-live](https://github.com/coenttb/swift-github-live) - Live HTTP implementations
- [swift-github](https://github.com/coenttb/swift-github) - High-level client with dependency injection
- [swift-dependencies](https://github.com/pointfreeco/swift-dependencies) - Dependency injection framework
- [swift-types-foundation](https://github.com/coenttb/swift-types-foundation) - Foundation type extensions

## Requirements

- Swift 6.0+
- macOS 14+ / iOS 17+ / Linux

## License

This package is licensed under the Apache 2.0 License. See [LICENSE](LICENSE) for details.

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/coenttb/swift-github-types).
