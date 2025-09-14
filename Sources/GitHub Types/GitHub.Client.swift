//
//  GitHub.Client.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import GitHub_Types_Shared
import GitHub_Traffic_Types
import GitHub_Repositories_Types
import GitHub_Stargazers_Types
import GitHub_OAuth_Types
import GitHub_Collaborators_Types

// https://docs.github.com/en/rest?apiVersion=2022-11-28
extension GitHub {
    @DependencyClient
    public struct Client: Sendable {
        public var traffic: Traffic.Client
        public var repositories: Repositories.Client
        public var stargazers: Stargazers.Client
        public var oauth: OAuth.Client
        public var collaborators: Collaborators.Client

        public init(
            traffic: Traffic.Client,
            repositories: Repositories.Client,
            stargazers: Stargazers.Client,
            oauth: OAuth.Client,
            collaborators: Collaborators.Client
        ) {
            self.traffic = traffic
            self.repositories = repositories
            self.stargazers = stargazers
            self.oauth = oauth
            self.collaborators = collaborators
        }
    }
}