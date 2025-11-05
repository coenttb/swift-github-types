//
//  Common.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import TypesFoundation

extension GitHub {
    // Common timestamp type used across GitHub API
    public typealias Timestamp = Date

    // Repository identifier
    public struct Repository: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, Int>

        public let id: ID
        public let nodeId: String
        public let name: String
        public let fullName: String
        public let `private`: Bool
        public let owner: Owner
        public let htmlUrl: URL
        public let description: String?
        public let fork: Bool
        public let url: URL
        public let createdAt: Timestamp
        public let updatedAt: Timestamp
        public let pushedAt: Timestamp?
        public let size: Int
        public let stargazersCount: Int
        public let watchersCount: Int
        public let language: String?
        public let hasIssues: Bool
        public let hasProjects: Bool
        public let hasDownloads: Bool
        public let hasWiki: Bool
        public let hasPages: Bool
        public let forksCount: Int
        public let archived: Bool
        public let disabled: Bool
        public let openIssuesCount: Int
        public let license: License?
        public let allowForking: Bool
        public let isTemplate: Bool
        public let topics: [String]
        public let visibility: String
        public let defaultBranch: String

        public init(
            id: ID,
            nodeId: String,
            name: String,
            fullName: String,
            private: Bool,
            owner: Owner,
            htmlUrl: URL,
            description: String?,
            fork: Bool,
            url: URL,
            createdAt: Timestamp,
            updatedAt: Timestamp,
            pushedAt: Timestamp?,
            size: Int,
            stargazersCount: Int,
            watchersCount: Int,
            language: String?,
            hasIssues: Bool,
            hasProjects: Bool,
            hasDownloads: Bool,
            hasWiki: Bool,
            hasPages: Bool,
            forksCount: Int,
            archived: Bool,
            disabled: Bool,
            openIssuesCount: Int,
            license: License?,
            allowForking: Bool,
            isTemplate: Bool,
            topics: [String],
            visibility: String,
            defaultBranch: String
        ) {
            self.id = id
            self.nodeId = nodeId
            self.name = name
            self.fullName = fullName
            self.private = `private`
            self.owner = owner
            self.htmlUrl = htmlUrl
            self.description = description
            self.fork = fork
            self.url = url
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.pushedAt = pushedAt
            self.size = size
            self.stargazersCount = stargazersCount
            self.watchersCount = watchersCount
            self.language = language
            self.hasIssues = hasIssues
            self.hasProjects = hasProjects
            self.hasDownloads = hasDownloads
            self.hasWiki = hasWiki
            self.hasPages = hasPages
            self.forksCount = forksCount
            self.archived = archived
            self.disabled = disabled
            self.openIssuesCount = openIssuesCount
            self.license = license
            self.allowForking = allowForking
            self.isTemplate = isTemplate
            self.topics = topics
            self.visibility = visibility
            self.defaultBranch = defaultBranch
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case nodeId = "node_id"
            case name
            case fullName = "full_name"
            case `private`
            case owner
            case htmlUrl = "html_url"
            case description
            case fork
            case url
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case pushedAt = "pushed_at"
            case size
            case stargazersCount = "stargazers_count"
            case watchersCount = "watchers_count"
            case language
            case hasIssues = "has_issues"
            case hasProjects = "has_projects"
            case hasDownloads = "has_downloads"
            case hasWiki = "has_wiki"
            case hasPages = "has_pages"
            case forksCount = "forks_count"
            case archived
            case disabled
            case openIssuesCount = "open_issues_count"
            case license
            case allowForking = "allow_forking"
            case isTemplate = "is_template"
            case topics
            case visibility
            case defaultBranch = "default_branch"
        }
    }

    public struct Owner: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, Int>

        public let id: Owner.ID
        public let login: String
        public let nodeId: String
        public let avatarUrl: URL
        public let gravatarId: String
        public let url: URL
        public let htmlUrl: URL
        public let type: String
        public let siteAdmin: Bool

        public init(
            id: Owner.ID,
            login: String,
            nodeId: String,
            avatarUrl: URL,
            gravatarId: String,
            url: URL,
            htmlUrl: URL,
            type: String,
            siteAdmin: Bool
        ) {
            self.id = id
            self.login = login
            self.nodeId = nodeId
            self.avatarUrl = avatarUrl
            self.gravatarId = gravatarId
            self.url = url
            self.htmlUrl = htmlUrl
            self.type = type
            self.siteAdmin = siteAdmin
        }

        private enum CodingKeys: String, CodingKey {
            case login
            case id
            case nodeId = "node_id"
            case avatarUrl = "avatar_url"
            case gravatarId = "gravatar_id"
            case url
            case htmlUrl = "html_url"
            case type
            case siteAdmin = "site_admin"
        }
    }

    public struct License: Codable, Equatable, Sendable {
        public let key: String
        public let name: String
        public let spdxId: String
        public let url: URL?
        public let nodeId: String

        public init(key: String, name: String, spdxId: String, url: URL?, nodeId: String) {
            self.key = key
            self.name = name
            self.spdxId = spdxId
            self.url = url
            self.nodeId = nodeId
        }

        private enum CodingKeys: String, CodingKey {
            case key
            case name
            case spdxId = "spdx_id"
            case url
            case nodeId = "node_id"
        }
    }
}
