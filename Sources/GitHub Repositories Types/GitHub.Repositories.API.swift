//
//  GitHub.Repositories.API.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import GitHub_Types_Shared

extension GitHub.Repositories {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.github.com/en/rest/repos/repos#list-repositories-for-the-authenticated-user
        case list(request: GitHub.Repositories.List.Request? = nil)
        
        // https://docs.github.com/en/rest/repos/repos#get-a-repository
        case get(owner: String, repo: String)
        
        // https://docs.github.com/en/rest/repos/repos#create-a-repository-for-the-authenticated-user
        case create(request: Create.Request)
        
        // https://docs.github.com/en/rest/repos/repos#update-a-repository
        case update(owner: String, repo: String, request: Update.Request)
        
        // https://docs.github.com/en/rest/repos/repos#delete-a-repository
        case delete(owner: String, repo: String)
    }
}

extension GitHub.Repositories.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<GitHub.Repositories.API> {
            OneOf {
                // https://docs.github.com/en/rest/repos/repos#list-repositories-for-the-authenticated-user
                URLRouting.Route(.case(GitHub.Repositories.API.list)) {
                    Method.get
                    Path { "user" }
                    Path { "repos" }
                    URLRouting.Query {
                        Optionally {
                            Parse(.memberwise(GitHub.Repositories.List.Request.init)) {
                                Optionally {
                                    Field("visibility") { Parse(.string.representing(GitHub.Repositories.List.Request.Visibility.self)) }
                                }
                                Optionally {
                                    Field("affiliation") { Parse(.string) }
                                }
                                Optionally {
                                    Field("type") { Parse(.string.representing(GitHub.Repositories.List.Request.RepoType.self)) }
                                }
                                Optionally {
                                    Field("sort") { Parse(.string.representing(GitHub.Repositories.List.Request.Sort.self)) }
                                }
                                Optionally {
                                    Field("direction") { Parse(.string.representing(GitHub.Repositories.List.Request.Direction.self)) }
                                }
                                Optionally {
                                    Field("per_page") { Digits() }
                                }
                                Optionally {
                                    Field("page") { Digits() }
                                }
                                Optionally {
                                    Field("since") {
                                        Parse(.string.map(
                                            .convert(
                                                apply: { ISO8601DateFormatter().date(from: $0) },
                                                unapply: { ISO8601DateFormatter().string(from: $0) }
                                            )
                                        ))
                                    }
                                }
                                Optionally {
                                    Field("before") {
                                        Parse(.string.map(
                                            .convert(
                                                apply: { ISO8601DateFormatter().date(from: $0) },
                                                unapply: { ISO8601DateFormatter().string(from: $0) }
                                            )
                                        ))
                                    }
                                }
                            }
                        }
                    }
                }
                
                // https://docs.github.com/en/rest/repos/repos#get-a-repository
                URLRouting.Route(.case(GitHub.Repositories.API.get)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                }
                
                // https://docs.github.com/en/rest/repos/repos#create-a-repository-for-the-authenticated-user
                URLRouting.Route(.case(GitHub.Repositories.API.create)) {
                    Method.post
                    Path { "user" }
                    Path { "repos" }
                    Body(.json(GitHub.Repositories.Create.Request.self))
                }
                
                // https://docs.github.com/en/rest/repos/repos#update-a-repository
                URLRouting.Route(.case(GitHub.Repositories.API.update)) {
                    Method.patch
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Body(.json(GitHub.Repositories.Update.Request.self))
                }
                
                // https://docs.github.com/en/rest/repos/repos#delete-a-repository
                URLRouting.Route(.case(GitHub.Repositories.API.delete)) {
                    Method.delete
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                }
            }
        }
    }
}
