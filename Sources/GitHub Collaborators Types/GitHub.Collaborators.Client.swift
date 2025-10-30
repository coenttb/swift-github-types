//
//  GitHub.Collaborators.Client.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2025.
//

import GitHub_Types_Shared

extension GitHub.Collaborators {
  @DependencyClient
  public struct Client: Sendable {
    // https://docs.github.com/en/rest/collaborators/collaborators#list-repository-collaborators
    @DependencyEndpoint
    public var list:
      @Sendable (_ owner: String, _ repo: String, _ request: List.Request?) async throws ->
        List.Response

    // https://docs.github.com/en/rest/collaborators/collaborators#check-if-a-user-is-a-repository-collaborator
    @DependencyEndpoint
    public var check:
      @Sendable (_ owner: String, _ repo: String, _ username: String) async throws -> Void

    // https://docs.github.com/en/rest/collaborators/collaborators#add-a-repository-collaborator
    @DependencyEndpoint
    public var add:
      @Sendable (_ owner: String, _ repo: String, _ username: String, _ request: Add.Request?)
        async throws -> Add.Response

    // https://docs.github.com/en/rest/collaborators/collaborators#remove-a-repository-collaborator
    @DependencyEndpoint
    public var remove:
      @Sendable (_ owner: String, _ repo: String, _ username: String) async throws -> Void

    // https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user
    @DependencyEndpoint
    public var getPermission:
      @Sendable (_ owner: String, _ repo: String, _ username: String) async throws ->
        GetPermission.Response

    // https://docs.github.com/en/rest/collaborators/invitations#list-repository-invitations
    @DependencyEndpoint
    public var listInvitations:
      @Sendable (_ owner: String, _ repo: String, _ request: Invitations.List.Request?) async throws
        -> Invitations.List.Response

    // https://docs.github.com/en/rest/collaborators/invitations#update-a-repository-invitation
    @DependencyEndpoint
    public var updateInvitation:
      @Sendable (
        _ owner: String, _ repo: String, _ invitationId: Int, _ request: Invitations.Update.Request
      ) async throws -> Invitations.Update.Response

    // https://docs.github.com/en/rest/collaborators/invitations#delete-a-repository-invitation
    @DependencyEndpoint
    public var deleteInvitation:
      @Sendable (_ owner: String, _ repo: String, _ invitationId: Int) async throws -> Void
  }
}

// MARK: - Convenience Methods

extension GitHub.Collaborators.Client {
  public func list(owner: String, repo: String) async throws -> GitHub.Collaborators.List.Response {
    try await self.list(owner: owner, repo: repo, request: nil)
  }

  public func add(
    owner: String,
    repo: String,
    username: String
  ) async throws -> GitHub.Collaborators.Add.Response {
    try await self.add(owner: owner, repo: repo, username: username, request: nil)
  }

  public func add(
    owner: String,
    repo: String,
    username: String,
    permission: GitHub.Collaborators.Permission
  ) async throws -> GitHub.Collaborators.Add.Response {
    try await self.add(
      owner: owner,
      repo: repo,
      username: username,
      request: .init(permission: permission)
    )
  }

  public func listInvitations(
    owner: String,
    repo: String
  ) async throws -> GitHub.Collaborators.Invitations.List.Response {
    try await self.listInvitations(owner: owner, repo: repo, request: nil)
  }
}
