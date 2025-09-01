//
//  GitHub.Stargazers.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 30/08/2025.
//

import GitHub_Types_Shared
import Foundation

// https://docs.github.com/en/rest/activity/starring
extension GitHub {
    public enum Stargazers: Sendable {}
}

extension GitHub.Stargazers {
    // https://docs.github.com/en/rest/activity/starring#list-stargazers
    public enum List {}
}

// MARK: - List Stargazers

extension GitHub.Stargazers.List {
    public struct Request: Codable, Equatable, Sendable {
        public var perPage: Int?
        public var page: Int?
        
        public init(
            perPage: Int? = nil,
            page: Int? = nil
        ) {
            self.perPage = perPage
            self.page = page
        }
        
        private enum CodingKeys: String, CodingKey {
            case perPage = "per_page"
            case page
        }
    }
    
    public typealias Response = [Stargazer]
    
    public struct Stargazer: Codable, Equatable, Sendable {
        public let user: GitHub.User
        public let starredAt: GitHub.Timestamp
        
        public init(
            user: GitHub.User,
            starredAt: GitHub.Timestamp
        ) {
            self.user = user
            self.starredAt = starredAt
        }
        
        private enum CodingKeys: String, CodingKey {
            case user
            case starredAt = "starred_at"
        }
    }
}

// Simplified User model for stargazers (we can expand this later if needed)
extension GitHub {
    public struct User: Codable, Equatable, Sendable {
        public let login: String
        public let id: Int
        public let nodeId: String
        public let avatarUrl: String
        public let gravatarId: String?
        public let url: String
        public let htmlUrl: String
        public let type: String
        public let siteAdmin: Bool
        
        public init(
            login: String,
            id: Int,
            nodeId: String,
            avatarUrl: String,
            gravatarId: String?,
            url: String,
            htmlUrl: String,
            type: String,
            siteAdmin: Bool
        ) {
            self.login = login
            self.id = id
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
}