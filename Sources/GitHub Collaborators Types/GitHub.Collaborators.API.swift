//
//  GitHub.Collaborators.API.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 14/09/2025.
//

import GitHub_Types_Shared

extension GitHub.Collaborators {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.github.com/en/rest/collaborators/collaborators#list-repository-collaborators
        case list(owner: String, repo: String, request: GitHub.Collaborators.List.Request? = nil)

        // https://docs.github.com/en/rest/collaborators/collaborators#check-if-a-user-is-a-repository-collaborator
        case check(owner: String, repo: String, username: String)

        // https://docs.github.com/en/rest/collaborators/collaborators#add-a-repository-collaborator
        case add(owner: String, repo: String, username: String, request: GitHub.Collaborators.Add.Request? = nil)

        // https://docs.github.com/en/rest/collaborators/collaborators#remove-a-repository-collaborator
        case remove(owner: String, repo: String, username: String)

        // https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user
        case getPermission(owner: String, repo: String, username: String)

        // https://docs.github.com/en/rest/collaborators/invitations#list-repository-invitations
        case listInvitations(owner: String, repo: String, request: GitHub.Collaborators.Invitations.List.Request? = nil)

        // https://docs.github.com/en/rest/collaborators/invitations#update-a-repository-invitation
        case updateInvitation(owner: String, repo: String, invitationId: Int, request: GitHub.Collaborators.Invitations.Update.Request)

        // https://docs.github.com/en/rest/collaborators/invitations#delete-a-repository-invitation
        case deleteInvitation(owner: String, repo: String, invitationId: Int)
    }
}

extension GitHub.Collaborators.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<GitHub.Collaborators.API> {
            OneOf {
                // https://docs.github.com/en/rest/collaborators/collaborators#list-repository-collaborators
                URLRouting.Route(.case(GitHub.Collaborators.API.list)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "collaborators" }
                    URLRouting.Query {
                        Optionally {
                            Parse(.memberwise(GitHub.Collaborators.List.Request.init)) {
                                Optionally {
                                    Field("affiliation") { Parse(.string.representing(GitHub.Collaborators.List.Request.Affiliation.self)) }
                                }
                                Optionally {
                                    Field("permission") { Parse(.string.representing(GitHub.Collaborators.Permission.self)) }
                                }
                                Optionally {
                                    Field("per_page") { Digits() }
                                }
                                Optionally {
                                    Field("page") { Digits() }
                                }
                            }
                        }
                    }
                }

                // https://docs.github.com/en/rest/collaborators/collaborators#check-if-a-user-is-a-repository-collaborator
                URLRouting.Route(.case(GitHub.Collaborators.API.check)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "collaborators" }
                    Path { Parse(.string) }  // username
                }

                // https://docs.github.com/en/rest/collaborators/collaborators#add-a-repository-collaborator
                URLRouting.Route(.case(GitHub.Collaborators.API.add)) {
                    Method.put
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "collaborators" }
                    Path { Parse(.string) }  // username
                    Optionally {
                        Body(.json(GitHub.Collaborators.Add.Request.self))
                    }
                }

                // https://docs.github.com/en/rest/collaborators/collaborators#remove-a-repository-collaborator
                URLRouting.Route(.case(GitHub.Collaborators.API.remove)) {
                    Method.delete
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "collaborators" }
                    Path { Parse(.string) }  // username
                }

                // https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user
                URLRouting.Route(.case(GitHub.Collaborators.API.getPermission)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "collaborators" }
                    Path { Parse(.string) }  // username
                    Path { "permission" }
                }

                // https://docs.github.com/en/rest/collaborators/invitations#list-repository-invitations
                URLRouting.Route(.case(GitHub.Collaborators.API.listInvitations)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "invitations" }
                    URLRouting.Query {
                        Optionally {
                            Parse(.memberwise(GitHub.Collaborators.Invitations.List.Request.init)) {
                                Optionally {
                                    Field("per_page") { Digits() }
                                }
                                Optionally {
                                    Field("page") { Digits() }
                                }
                            }
                        }
                    }
                }

                // https://docs.github.com/en/rest/collaborators/invitations#update-a-repository-invitation
                URLRouting.Route(.case(GitHub.Collaborators.API.updateInvitation)) {
                    Method.patch
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "invitations" }
                    Path { Digits() }  // invitationId
                    Body(.json(GitHub.Collaborators.Invitations.Update.Request.self))
                }

                // https://docs.github.com/en/rest/collaborators/invitations#delete-a-repository-invitation
                URLRouting.Route(.case(GitHub.Collaborators.API.deleteInvitation)) {
                    Method.delete
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "invitations" }
                    Path { Digits() }  // invitationId
                }
            }
        }
    }
}
