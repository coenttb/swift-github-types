//
//  GitHub.Traffic.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import GitHub_Types_Shared

// https://docs.github.com/en/rest/metrics/traffic
extension GitHub {
    public enum Traffic: Sendable {}
}

extension GitHub.Traffic {
    public enum Per: String, Codable, Equatable, Sendable, CaseIterable {
        case day
        case week
    }

    // https://docs.github.com/en/rest/metrics/traffic#get-repository-views
    public enum Views {}

    // https://docs.github.com/en/rest/metrics/traffic#get-repository-clones
    public enum Clones {}

    // https://docs.github.com/en/rest/metrics/traffic#get-top-referral-paths
    public enum Paths {}

    // https://docs.github.com/en/rest/metrics/traffic#get-top-referral-sources
    public enum Referrers {}
}

// MARK: - Views

extension GitHub.Traffic.Views {
    public struct Response: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let count: Int
        public let uniques: Int
        public let views: [View]

        public init(
            count: Int,
            uniques: Int,
            views: [View]
        ) {
            self.count = count
            self.uniques = uniques
            self.views = views
        }

        public var debugDescription: String {
            """
            GitHub.Traffic.Views.Response:
              Total views: \(count)
              Unique visitors: \(uniques)
              Daily breakdown: \(views.count) days
            \(views.map { "    \($0.debugDescription)" }.joined(separator: "\n"))
            """
        }
    }

    public struct View: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let timestamp: GitHub.Timestamp
        public let count: Int
        public let uniques: Int

        public init(
            timestamp: GitHub.Timestamp,
            count: Int,
            uniques: Int
        ) {
            self.timestamp = timestamp
            self.count = count
            self.uniques = uniques
        }

        public var debugDescription: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(identifier: "UTC")
            let dateString = formatter.string(from: timestamp)
            return "[\(dateString)] views: \(count), uniques: \(uniques)"
        }
    }
}

// MARK: - Clones

extension GitHub.Traffic.Clones {
    public struct Response: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let count: Int
        public let uniques: Int
        public let clones: [Clone]

        public init(
            count: Int,
            uniques: Int,
            clones: [Clone]
        ) {
            self.count = count
            self.uniques = uniques
            self.clones = clones
        }

        public var debugDescription: String {
            """
            GitHub.Traffic.Clones.Response:
              Total clones: \(count)
              Unique cloners: \(uniques)
              Daily breakdown: \(clones.count) days
            \(clones.map { "    \($0.debugDescription)" }.joined(separator: "\n"))
            """
        }
    }

    public struct Clone: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let timestamp: GitHub.Timestamp
        public let count: Int
        public let uniques: Int

        public init(
            timestamp: GitHub.Timestamp,
            count: Int,
            uniques: Int
        ) {
            self.timestamp = timestamp
            self.count = count
            self.uniques = uniques
        }

        public var debugDescription: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(identifier: "UTC")
            let dateString = formatter.string(from: timestamp)
            return "[\(dateString)] clones: \(count), uniques: \(uniques)"
        }
    }
}

// MARK: - Paths

extension GitHub.Traffic.Paths {
    public struct Response: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let paths: [Path]

        public var count: Int { paths.count }

        public init(paths: [Path]) {
            self.paths = paths
        }

        // Custom decoding since GitHub returns array directly
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.paths = try container.decode([Path].self)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(paths)
        }

        public var debugDescription: String {
            """
            GitHub.Traffic.Paths.Response:
              Top paths: \(paths.count)
            \(paths.map { "    \($0.debugDescription)" }.joined(separator: "\n"))
            """
        }
    }

    public struct Path: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let path: String
        public let title: String
        public let count: Int
        public let uniques: Int

        public init(
            path: String,
            title: String,
            count: Int,
            uniques: Int
        ) {
            self.path = path
            self.title = title
            self.count = count
            self.uniques = uniques
        }

        public var debugDescription: String {
            "\(path) - \(title): views: \(count), uniques: \(uniques)"
        }
    }
}

// MARK: - Referrers

extension GitHub.Traffic.Referrers {
    public struct Response: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let referrers: [Referrer]

        public var count: Int {
            referrers.count
        }

        public init(referrers: [Referrer]) {
            self.referrers = referrers
        }

        // Custom decoding since GitHub returns array directly
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.referrers = try container.decode([Referrer].self)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(referrers)
        }

        public var debugDescription: String {
            """
            GitHub.Traffic.Referrers.Response:
              Top referrers: \(referrers.count)
            \(referrers.map { "    \($0.debugDescription)" }.joined(separator: "\n"))
            """
        }
    }

    public struct Referrer: Codable, Equatable, Sendable, CustomDebugStringConvertible {
        public let referrer: String
        public let count: Int
        public let uniques: Int

        public init(
            referrer: String,
            count: Int,
            uniques: Int
        ) {
            self.referrer = referrer
            self.count = count
            self.uniques = uniques
        }

        public var debugDescription: String {
            "\(referrer): views: \(count), uniques: \(uniques)"
        }
    }
}
