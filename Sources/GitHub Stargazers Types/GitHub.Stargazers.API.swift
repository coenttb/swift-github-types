//
//  GitHub.Stargazers.API.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 30/08/2025.
//

import Dependencies
import DependenciesMacros
import Foundation
import GitHub_Types_Shared
import URLRouting

extension GitHub.Stargazers {
  public enum API: Equatable, Sendable {
    case list(owner: String, repo: String, request: GitHub.Stargazers.List.Request?)
  }
}

extension GitHub.Stargazers.API {
  @DependencyClient
  public struct Router: ParserPrinter, Sendable {
    public typealias Input = URLRequestData
    public typealias Output = GitHub.Stargazers.API

    public init() {}

    public var body: some URLRouting.Router<GitHub.Stargazers.API> {
      OneOf {
        URLRouting.Route(.case(GitHub.Stargazers.API.list)) {
          Method.get
          Path {
            "repos"
            Parse(.string)
            Parse(.string)
            "stargazers"
          }
          Headers {
            // Required header for getting starred_at timestamps
            Field("Accept") { "application/vnd.github.star+json" }
          }
          Query {
            Optionally {
              Parse(.memberwise(GitHub.Stargazers.List.Request.init)) {
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
      }
    }
  }
}
