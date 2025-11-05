//
//  GitHub.Traffic.API.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import GitHub_Types_Shared

extension GitHub.Traffic {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.github.com/en/rest/metrics/traffic#get-repository-views
        case views(owner: String, repo: String, per: Per?)

        // https://docs.github.com/en/rest/metrics/traffic#get-repository-clones
        case clones(owner: String, repo: String, per: Per?)

        // https://docs.github.com/en/rest/metrics/traffic#get-top-referral-paths
        case paths(owner: String, repo: String)

        // https://docs.github.com/en/rest/metrics/traffic#get-top-referral-sources
        case referrers(owner: String, repo: String)
    }
}

extension GitHub.Traffic.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<GitHub.Traffic.API> {
            OneOf {
                // https://docs.github.com/en/rest/metrics/traffic#get-repository-views
                URLRouting.Route(.case(GitHub.Traffic.API.views)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "traffic" }
                    Path { "views" }
                    URLRouting.Query {
                        Optionally {
                            Field("per") { Parse(.string.representing(GitHub.Traffic.Per.self)) }
                        }
                    }
                }

                // https://docs.github.com/en/rest/metrics/traffic#get-repository-clones
                URLRouting.Route(.case(GitHub.Traffic.API.clones)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "traffic" }
                    Path { "clones" }
                    URLRouting.Query {
                        Optionally {
                            Field("per") { Parse(.string.representing(GitHub.Traffic.Per.self)) }
                        }
                    }
                }

                // https://docs.github.com/en/rest/metrics/traffic#get-top-referral-paths
                URLRouting.Route(.case(GitHub.Traffic.API.paths)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "traffic" }
                    Path { "popular" }
                    Path { "paths" }
                }

                // https://docs.github.com/en/rest/metrics/traffic#get-top-referral-sources
                URLRouting.Route(.case(GitHub.Traffic.API.referrers)) {
                    Method.get
                    Path { "repos" }
                    Path { Parse(.string) }  // owner
                    Path { Parse(.string) }  // repo
                    Path { "traffic" }
                    Path { "popular" }
                    Path { "referrers" }
                }
            }
        }
    }
}
