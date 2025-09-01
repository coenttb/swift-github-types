//
//  GitHub.API.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import GitHub_Types_Shared
import GitHub_Traffic_Types
import GitHub_Repositories_Types
import GitHub_Stargazers_Types

// https://docs.github.com/en/rest?apiVersion=2022-11-28
extension GitHub {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case traffic(Traffic.API)
        case repositories(Repositories.API)
        case stargazers(Stargazers.API)
    }
}

extension GitHub.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<GitHub.API> {
            OneOf {
                URLRouting.Route(.case(GitHub.API.traffic)) {
                    GitHub.Traffic.API.Router()
                }
                
                URLRouting.Route(.case(GitHub.API.repositories)) {
                    GitHub.Repositories.API.Router()
                }
                
                URLRouting.Route(.case(GitHub.API.stargazers)) {
                    GitHub.Stargazers.API.Router()
                }
            }
        }
    }
}