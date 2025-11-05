//
//  GitHub.OAuth.API.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 10/09/2025.
//

import Foundation
import GitHub_Types_Shared

extension GitHub.OAuth {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Sendable, Equatable {
        case exchangeCode(TokenRequest)
        case getAuthenticatedUser(accessToken: String)
        case getUserEmails(accessToken: String)
    }
}

//extension GitHub.OAuth.API {
//    public var endpoint: String {
//        switch self {
//        case .exchangeCode:
//            return "https://github.com/login/oauth/access_token"
//        case .getAuthenticatedUser:
//            return "/user"
//        case .getUserEmails:
//            return "/user/emails"
//        }
//    }
//
//    public var method: String {
//        switch self {
//        case .exchangeCode:
//            return "POST"
//        case .getAuthenticatedUser, .getUserEmails:
//            return "GET"
//        }
//    }
//
//    public var headers: [String: String] {
//        var headers = ["Accept": "application/json"]
//
//        switch self {
//        case .getAuthenticatedUser(let token), .getUserEmails(let token):
//            headers["Authorization"] = "Bearer \(token)"
//        default:
//            break
//        }
//
//        return headers
//    }
//}

extension GitHub.OAuth.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<GitHub.OAuth.API> {
            OneOf {
                // OAuth endpoints are special - they're not under the regular API path
                // Exchange code endpoint is at GitHub.com, not api.github.com
                URLRouting.Route(.case(GitHub.OAuth.API.exchangeCode)) {
                    Method.post
                    Path { "login" }
                    Path { "oauth" }
                    Path { "access_token" }
                    Body(.json(GitHub.OAuth.TokenRequest.self))
                }

                // Get authenticated user
                URLRouting.Route(.case(GitHub.OAuth.API.getAuthenticatedUser)) {
                    Method.get
                    Path { "user" }
                    Headers {
                        Field("Authorization", .string)
                    }
                }

                // Get user emails
                URLRouting.Route(.case(GitHub.OAuth.API.getUserEmails)) {
                    Method.get
                    Path { "user" }
                    Path { "emails" }
                    Headers {
                        Field("Authorization", .string)
                    }
                }
            }
        }
    }
}
