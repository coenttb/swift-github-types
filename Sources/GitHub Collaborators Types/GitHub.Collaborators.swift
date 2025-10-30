//
//  GitHub.Collaborators.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2025.
//

import GitHub_Types_Shared

// https://docs.github.com/en/rest/collaborators/collaborators
extension GitHub {
  public enum Collaborators: Sendable {}
}

// MARK: - Permission Level

extension GitHub.Collaborators {
  public enum Permission: String, Codable, Equatable, Sendable, CaseIterable {
    case pull
    case triage
    case push
    case maintain
    case admin
  }
}

// MARK: - List

extension GitHub.Collaborators {
  public enum List {}
}

extension GitHub.Collaborators.List {
  public struct Request: Codable, Equatable, Sendable {
    public let affiliation: Affiliation?
    public let permission: GitHub.Collaborators.Permission?
    public let perPage: Int?
    public let page: Int?

    public init(
      affiliation: Affiliation? = nil,
      permission: GitHub.Collaborators.Permission? = nil,
      perPage: Int? = nil,
      page: Int? = nil
    ) {
      self.affiliation = affiliation
      self.permission = permission
      self.perPage = perPage
      self.page = page
    }

    private enum CodingKeys: String, CodingKey {
      case affiliation
      case permission
      case perPage = "per_page"
      case page
    }

    public enum Affiliation: String, Codable, Equatable, Sendable {
      case outside
      case direct
      case all
    }
  }

  public typealias Response = [GitHub.Collaborator]
}

// MARK: - Check

extension GitHub.Collaborators {
  public enum Check {}
}

extension GitHub.Collaborators.Check {
  public struct Response: Codable, Equatable, Sendable {
    public let message: String?
    public let documentationUrl: String?

    public init(
      message: String? = nil,
      documentationUrl: String? = nil
    ) {
      self.message = message
      self.documentationUrl = documentationUrl
    }

    private enum CodingKeys: String, CodingKey {
      case message
      case documentationUrl = "documentation_url"
    }
  }
}

// MARK: - Add

extension GitHub.Collaborators {
  public enum Add {}
}

extension GitHub.Collaborators.Add {
  public struct Request: Codable, Equatable, Sendable {
    public let permission: GitHub.Collaborators.Permission?

    public init(permission: GitHub.Collaborators.Permission? = nil) {
      self.permission = permission
    }
  }

  public struct Response: Codable, Equatable, Sendable {
    public let id: Int
    public let nodeId: String
    public let repositoryId: Int
    public let invitee: GitHub.User?
    public let inviter: GitHub.User?
    public let permissions: GitHub.Collaborators.Permission
    public let createdAt: GitHub.Timestamp
    public let expired: Bool?
    public let url: URL
    public let htmlUrl: URL

    public init(
      id: Int,
      nodeId: String,
      repositoryId: Int,
      invitee: GitHub.User?,
      inviter: GitHub.User?,
      permissions: GitHub.Collaborators.Permission,
      createdAt: GitHub.Timestamp,
      expired: Bool?,
      url: URL,
      htmlUrl: URL
    ) {
      self.id = id
      self.nodeId = nodeId
      self.repositoryId = repositoryId
      self.invitee = invitee
      self.inviter = inviter
      self.permissions = permissions
      self.createdAt = createdAt
      self.expired = expired
      self.url = url
      self.htmlUrl = htmlUrl
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case nodeId = "node_id"
      case repositoryId = "repository_id"
      case invitee
      case inviter
      case permissions
      case createdAt = "created_at"
      case expired
      case url
      case htmlUrl = "html_url"
    }
  }
}

// MARK: - Remove

extension GitHub.Collaborators {
  public enum Remove {}
}

extension GitHub.Collaborators.Remove {
  public struct Response: Codable, Equatable, Sendable {
    public let message: String?
    public let documentationUrl: String?

    public init(
      message: String? = nil,
      documentationUrl: String? = nil
    ) {
      self.message = message
      self.documentationUrl = documentationUrl
    }

    private enum CodingKeys: String, CodingKey {
      case message
      case documentationUrl = "documentation_url"
    }
  }
}

// MARK: - Get Permission

extension GitHub.Collaborators {
  public enum GetPermission {}
}

extension GitHub.Collaborators.GetPermission {
  public struct Response: Codable, Equatable, Sendable {
    public let permission: GitHub.Collaborators.Permission
    public let roleName: String
    public let user: GitHub.User

    public init(
      permission: GitHub.Collaborators.Permission,
      roleName: String,
      user: GitHub.User
    ) {
      self.permission = permission
      self.roleName = roleName
      self.user = user
    }

    private enum CodingKeys: String, CodingKey {
      case permission
      case roleName = "role_name"
      case user
    }
  }
}

// MARK: - Invitations

extension GitHub.Collaborators {
  public enum Invitations {}
}

// MARK: - List Invitations

extension GitHub.Collaborators.Invitations {
  public enum List {}
}

extension GitHub.Collaborators.Invitations.List {
  public struct Request: Codable, Equatable, Sendable {
    public let perPage: Int?
    public let page: Int?

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

  public typealias Response = [GitHub.RepositoryInvitation]
}

// MARK: - Update Invitation

extension GitHub.Collaborators.Invitations {
  public enum Update {}
}

extension GitHub.Collaborators.Invitations.Update {
  public struct Request: Codable, Equatable, Sendable {
    public let permissions: GitHub.Collaborators.Permission?

    public init(permissions: GitHub.Collaborators.Permission? = nil) {
      self.permissions = permissions
    }
  }

  public typealias Response = GitHub.RepositoryInvitation
}

// MARK: - Delete Invitation

extension GitHub.Collaborators.Invitations {
  public enum Delete {}
}

extension GitHub.Collaborators.Invitations.Delete {
  public struct Response: Codable, Equatable, Sendable {
    public let message: String?
    public let documentationUrl: String?

    public init(
      message: String? = nil,
      documentationUrl: String? = nil
    ) {
      self.message = message
      self.documentationUrl = documentationUrl
    }

    private enum CodingKeys: String, CodingKey {
      case message
      case documentationUrl = "documentation_url"
    }
  }
}

// MARK: - Supporting Types

extension GitHub {
  public struct Collaborator: Codable, Equatable, Sendable, Identifiable {
    public typealias ID = Tagged<Self, Int>

    public let id: ID
    public let login: String
    public let nodeId: String
    public let avatarUrl: URL
    public let gravatarId: String
    public let url: URL
    public let htmlUrl: URL
    public let followersUrl: URL
    public let followingUrl: URL
    public let gistsUrl: URL
    public let starredUrl: URL
    public let subscriptionsUrl: URL
    public let organizationsUrl: URL
    public let reposUrl: URL
    public let eventsUrl: URL
    public let receivedEventsUrl: URL
    public let type: String
    public let siteAdmin: Bool
    public let permissions: GitHub.Collaborators.Permission?
    public let roleName: String?

    public init(
      id: ID,
      login: String,
      nodeId: String,
      avatarUrl: URL,
      gravatarId: String,
      url: URL,
      htmlUrl: URL,
      followersUrl: URL,
      followingUrl: URL,
      gistsUrl: URL,
      starredUrl: URL,
      subscriptionsUrl: URL,
      organizationsUrl: URL,
      reposUrl: URL,
      eventsUrl: URL,
      receivedEventsUrl: URL,
      type: String,
      siteAdmin: Bool,
      permissions: GitHub.Collaborators.Permission? = nil,
      roleName: String? = nil
    ) {
      self.id = id
      self.login = login
      self.nodeId = nodeId
      self.avatarUrl = avatarUrl
      self.gravatarId = gravatarId
      self.url = url
      self.htmlUrl = htmlUrl
      self.followersUrl = followersUrl
      self.followingUrl = followingUrl
      self.gistsUrl = gistsUrl
      self.starredUrl = starredUrl
      self.subscriptionsUrl = subscriptionsUrl
      self.organizationsUrl = organizationsUrl
      self.reposUrl = reposUrl
      self.eventsUrl = eventsUrl
      self.receivedEventsUrl = receivedEventsUrl
      self.type = type
      self.siteAdmin = siteAdmin
      self.permissions = permissions
      self.roleName = roleName
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case login
      case nodeId = "node_id"
      case avatarUrl = "avatar_url"
      case gravatarId = "gravatar_id"
      case url
      case htmlUrl = "html_url"
      case followersUrl = "followers_url"
      case followingUrl = "following_url"
      case gistsUrl = "gists_url"
      case starredUrl = "starred_url"
      case subscriptionsUrl = "subscriptions_url"
      case organizationsUrl = "organizations_url"
      case reposUrl = "repos_url"
      case eventsUrl = "events_url"
      case receivedEventsUrl = "received_events_url"
      case type
      case siteAdmin = "site_admin"
      case permissions
      case roleName = "role_name"
    }
  }

  public struct User: Codable, Equatable, Sendable, Identifiable {
    public typealias ID = Tagged<Self, Int>

    public let id: ID
    public let login: String
    public let nodeId: String
    public let avatarUrl: URL
    public let gravatarId: String
    public let url: URL
    public let htmlUrl: URL
    public let type: String
    public let siteAdmin: Bool

    public init(
      id: ID,
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
      case id
      case login
      case nodeId = "node_id"
      case avatarUrl = "avatar_url"
      case gravatarId = "gravatar_id"
      case url
      case htmlUrl = "html_url"
      case type
      case siteAdmin = "site_admin"
    }
  }

  public struct RepositoryInvitation: Codable, Equatable, Sendable, Identifiable {
    public typealias ID = Tagged<Self, Int>

    public let id: ID
    public let nodeId: String
    public let repository: GitHub.Repository
    public let invitee: GitHub.User?
    public let inviter: GitHub.User?
    public let permissions: GitHub.Collaborators.Permission
    public let createdAt: GitHub.Timestamp
    public let expired: Bool?
    public let url: URL
    public let htmlUrl: URL

    public init(
      id: ID,
      nodeId: String,
      repository: GitHub.Repository,
      invitee: GitHub.User?,
      inviter: GitHub.User?,
      permissions: GitHub.Collaborators.Permission,
      createdAt: GitHub.Timestamp,
      expired: Bool?,
      url: URL,
      htmlUrl: URL
    ) {
      self.id = id
      self.nodeId = nodeId
      self.repository = repository
      self.invitee = invitee
      self.inviter = inviter
      self.permissions = permissions
      self.createdAt = createdAt
      self.expired = expired
      self.url = url
      self.htmlUrl = htmlUrl
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case nodeId = "node_id"
      case repository
      case invitee
      case inviter
      case permissions
      case createdAt = "created_at"
      case expired
      case url
      case htmlUrl = "html_url"
    }
  }
}
