//
//  GitHub.OAuth.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 10/09/2025.
//

import Foundation
import GitHub_Types_Shared

extension GitHub {
    public enum OAuth {}
}

extension GitHub.OAuth {
    /// Request body for exchanging authorization code for access token
    /// https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#2-users-are-redirected-back-to-your-site-by-github
    public struct TokenRequest: Codable, Equatable, Sendable {
        public let clientId: String
        public let clientSecret: String
        public let code: String
        public let redirectUri: String?
        
        public init(
            clientId: String,
            clientSecret: String,
            code: String,
            redirectUri: String? = nil
        ) {
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.code = code
            self.redirectUri = redirectUri
        }
        
        private enum CodingKeys: String, CodingKey {
            case clientId = "client_id"
            case clientSecret = "client_secret"
            case code
            case redirectUri = "redirect_uri"
        }
    }
    
    /// Response from token exchange endpoint
    public struct TokenResponse: Codable, Sendable {
        public let accessToken: String
        public let tokenType: String
        public let scope: String
        
        public init(
            accessToken: String,
            tokenType: String,
            scope: String
        ) {
            self.accessToken = accessToken
            self.tokenType = tokenType
            self.scope = scope
        }
        
        private enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case scope
        }
    }
    
    /// Error response from OAuth endpoints
    public struct ErrorResponse: Codable, Sendable, Error {
        public let error: String
        public let errorDescription: String?
        public let errorUri: String?
        
        private enum CodingKeys: String, CodingKey {
            case error
            case errorDescription = "error_description"
            case errorUri = "error_uri"
        }
    }
    
    /// User info response from authenticated user endpoint
    public struct User: Codable, Sendable {
        public let id: Int
        public let login: String
        public let name: String?
        public let email: String?
        public let avatarUrl: String?
        public let bio: String?
        public let company: String?
        public let blog: String?
        public let location: String?
        public let publicRepos: Int
        public let publicGists: Int
        public let followers: Int
        public let following: Int
        public let createdAt: Date
        public let updatedAt: Date
        
        private enum CodingKeys: String, CodingKey {
            case id
            case login
            case name
            case email
            case avatarUrl = "avatar_url"
            case bio
            case company
            case blog
            case location
            case publicRepos = "public_repos"
            case publicGists = "public_gists"
            case followers
            case following
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}
