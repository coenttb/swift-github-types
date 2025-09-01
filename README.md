# swift-github-types

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.1.0-green.svg)](https://github.com/coenttb/swift-github-types/releases)

Core types and protocols for interacting with the GitHub API in Swift.

## Overview

`swift-github-types` provides comprehensive type definitions for GitHub's REST API, including:

- 📊 **Traffic Analytics**: Views, clones, and repository traffic data
- ⭐ **Stargazers**: Star counts and stargazer information
- 📦 **Repositories**: Repository metadata and management
- 🔄 **Pagination**: Built-in support for GitHub's pagination
- 🎯 **Type Safety**: Strongly-typed API definitions with Codable support
- 🔌 **Dependency Injection**: Using swift-dependencies for testability

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-github-types", from: "0.1.0")
]
```

## Quick Start

### Using the Types

```swift
import GitHubTypes
import GitHubTrafficTypes
import GitHubRepositoriesTypes

// Work with strongly-typed GitHub data
let repository: GitHub.Repository
let traffic: GitHub.Traffic.Views
let stargazers: GitHub.Stargazers.List
```

### Client Protocols

The package defines client protocols for dependency injection:

```swift
// Define your GitHub client
@Dependency(\.githubClient) var githubClient

// Use type-safe API definitions
let views = try await githubClient.traffic.views(
    owner: "coenttb",
    repo: "swift-github-types"
)
```

## Architecture

The package is organized into modular components:

- **GitHubTypesShared**: Common types and utilities
- **GitHubTrafficTypes**: Traffic analytics types and client protocols
- **GitHubRepositoriesTypes**: Repository-related types and operations
- **GitHubStargazersTypes**: Stargazer types and endpoints
- **GitHubTypes**: Umbrella module that re-exports all types

### Type Organization

Each module follows a consistent pattern:

```swift
extension GitHub {
    public struct Traffic { 
        // Traffic-specific types
    }
    
    public struct Repositories {
        // Repository-specific types
    }
}
```

## Features

### Traffic Analytics

- Repository views and unique visitors
- Clone statistics
- Popular paths and referrers
- Historical traffic data

### Repository Management

- Repository metadata
- Branch information
- Commit statistics
- Contributor data

### Stargazers

- Star counts over time
- Stargazer user information
- Historical starring data

## Testing

The types are designed for easy testing with swift-dependencies:

```swift
import GitHubTypes
import Dependencies

@Test
func testGitHubClient() async throws {
    let client = GitHub.Client.test
    // Test with mock implementations
}
```

## Related Packages

- [swift-github-live](https://github.com/coenttb/swift-github-live): Live implementations (AGPL/Commercial)
- [swift-github](https://github.com/coenttb/swift-github): High-level client with dependency injection
- [swift-types-foundation](https://github.com/coenttb/swift-types-foundation): Foundation types

## Requirements

- Swift 6.0+
- macOS 14+ / iOS 17+ / Linux

## License

This package is licensed under the Apache 2.0 License. See [LICENSE](LICENSE) for details.

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/coenttb/swift-github-types).