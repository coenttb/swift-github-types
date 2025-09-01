//
//  GitHub.Repositories.swift
//  swift-github-types
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import GitHub_Types_Shared

// https://docs.github.com/en/rest/repos/repos
extension GitHub {
    public enum Repositories: Sendable {}
}

// MARK: - List

extension GitHub.Repositories {
    public enum List {}
}

extension GitHub.Repositories.List {
    public struct Request: Codable, Equatable, Sendable {
        public let visibility: Visibility?
        public let affiliation: String?
        public let type: RepoType?
        public let sort: Sort?
        public let direction: Direction?
        public let perPage: Int?
        public let page: Int?
        public let since: Date?
        public let before: Date?
        
        public init(
            visibility: Visibility? = nil,
            affiliation: String? = nil,
            type: RepoType? = nil,
            sort: Sort? = nil,
            direction: Direction? = nil,
            perPage: Int? = nil,
            page: Int? = nil,
            since: Date? = nil,
            before: Date? = nil
        ) {
            self.visibility = visibility
            self.affiliation = affiliation
            self.type = type
            self.sort = sort
            self.direction = direction
            self.perPage = perPage
            self.page = page
            self.since = since
            self.before = before
        }
        
        private enum CodingKeys: String, CodingKey {
            case visibility
            case affiliation
            case type
            case sort
            case direction
            case perPage = "per_page"
            case page
            case since
            case before
        }
        
        public enum Visibility: String, Codable, Equatable, Sendable {
            case all
            case `public`
            case `private`
        }
        
        public enum RepoType: String, Codable, Equatable, Sendable {
            case all
            case owner
            case `public`
            case `private`
            case member
        }
        
        public enum Sort: String, Codable, Equatable, Sendable {
            case created
            case updated
            case pushed
            case fullName = "full_name"
        }
        
        public enum Direction: String, Codable, Equatable, Sendable {
            case asc
            case desc
        }
    }
    
    public typealias Response = [GitHub.Repository]
}

// MARK: - Create

extension GitHub.Repositories {
    public enum Create {}
}

extension GitHub.Repositories.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let name: String
        public let description: String?
        public let homepage: String?
        public let `private`: Bool?
        public let visibility: String?
        public let hasIssues: Bool?
        public let hasProjects: Bool?
        public let hasWiki: Bool?
        public let hasDiscussions: Bool?
        public let teamId: Int?
        public let autoInit: Bool?
        public let gitignoreTemplate: String?
        public let licenseTemplate: String?
        public let allowSquashMerge: Bool?
        public let allowMergeCommit: Bool?
        public let allowRebaseMerge: Bool?
        public let allowAutoMerge: Bool?
        public let deleteBranchOnMerge: Bool?
        public let squashMergeCommitTitle: String?
        public let squashMergeCommitMessage: String?
        public let mergeCommitTitle: String?
        public let mergeCommitMessage: String?
        public let hasDownloads: Bool?
        public let isTemplate: Bool?
        
        public init(
            name: String,
            description: String? = nil,
            homepage: String? = nil,
            `private`: Bool? = nil,
            visibility: String? = nil,
            hasIssues: Bool? = nil,
            hasProjects: Bool? = nil,
            hasWiki: Bool? = nil,
            hasDiscussions: Bool? = nil,
            teamId: Int? = nil,
            autoInit: Bool? = nil,
            gitignoreTemplate: String? = nil,
            licenseTemplate: String? = nil,
            allowSquashMerge: Bool? = nil,
            allowMergeCommit: Bool? = nil,
            allowRebaseMerge: Bool? = nil,
            allowAutoMerge: Bool? = nil,
            deleteBranchOnMerge: Bool? = nil,
            squashMergeCommitTitle: String? = nil,
            squashMergeCommitMessage: String? = nil,
            mergeCommitTitle: String? = nil,
            mergeCommitMessage: String? = nil,
            hasDownloads: Bool? = nil,
            isTemplate: Bool? = nil
        ) {
            self.name = name
            self.description = description
            self.homepage = homepage
            self.private = `private`
            self.visibility = visibility
            self.hasIssues = hasIssues
            self.hasProjects = hasProjects
            self.hasWiki = hasWiki
            self.hasDiscussions = hasDiscussions
            self.teamId = teamId
            self.autoInit = autoInit
            self.gitignoreTemplate = gitignoreTemplate
            self.licenseTemplate = licenseTemplate
            self.allowSquashMerge = allowSquashMerge
            self.allowMergeCommit = allowMergeCommit
            self.allowRebaseMerge = allowRebaseMerge
            self.allowAutoMerge = allowAutoMerge
            self.deleteBranchOnMerge = deleteBranchOnMerge
            self.squashMergeCommitTitle = squashMergeCommitTitle
            self.squashMergeCommitMessage = squashMergeCommitMessage
            self.mergeCommitTitle = mergeCommitTitle
            self.mergeCommitMessage = mergeCommitMessage
            self.hasDownloads = hasDownloads
            self.isTemplate = isTemplate
        }
        
        private enum CodingKeys: String, CodingKey {
            case name
            case description
            case homepage
            case `private`
            case visibility
            case hasIssues = "has_issues"
            case hasProjects = "has_projects"
            case hasWiki = "has_wiki"
            case hasDiscussions = "has_discussions"
            case teamId = "team_id"
            case autoInit = "auto_init"
            case gitignoreTemplate = "gitignore_template"
            case licenseTemplate = "license_template"
            case allowSquashMerge = "allow_squash_merge"
            case allowMergeCommit = "allow_merge_commit"
            case allowRebaseMerge = "allow_rebase_merge"
            case allowAutoMerge = "allow_auto_merge"
            case deleteBranchOnMerge = "delete_branch_on_merge"
            case squashMergeCommitTitle = "squash_merge_commit_title"
            case squashMergeCommitMessage = "squash_merge_commit_message"
            case mergeCommitTitle = "merge_commit_title"
            case mergeCommitMessage = "merge_commit_message"
            case hasDownloads = "has_downloads"
            case isTemplate = "is_template"
        }
    }
}

// MARK: - Update

extension GitHub.Repositories {
    public enum Update {}
}

extension GitHub.Repositories.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let name: String?
        public let description: String?
        public let homepage: String?
        public let `private`: Bool?
        public let visibility: String?
        public let hasIssues: Bool?
        public let hasProjects: Bool?
        public let hasWiki: Bool?
        public let isTemplate: Bool?
        public let defaultBranch: String?
        public let allowSquashMerge: Bool?
        public let allowMergeCommit: Bool?
        public let allowRebaseMerge: Bool?
        public let allowAutoMerge: Bool?
        public let deleteBranchOnMerge: Bool?
        public let archived: Bool?
        public let allowForking: Bool?
        
        public init(
            name: String? = nil,
            description: String? = nil,
            homepage: String? = nil,
            `private`: Bool? = nil,
            visibility: String? = nil,
            hasIssues: Bool? = nil,
            hasProjects: Bool? = nil,
            hasWiki: Bool? = nil,
            isTemplate: Bool? = nil,
            defaultBranch: String? = nil,
            allowSquashMerge: Bool? = nil,
            allowMergeCommit: Bool? = nil,
            allowRebaseMerge: Bool? = nil,
            allowAutoMerge: Bool? = nil,
            deleteBranchOnMerge: Bool? = nil,
            archived: Bool? = nil,
            allowForking: Bool? = nil
        ) {
            self.name = name
            self.description = description
            self.homepage = homepage
            self.private = `private`
            self.visibility = visibility
            self.hasIssues = hasIssues
            self.hasProjects = hasProjects
            self.hasWiki = hasWiki
            self.isTemplate = isTemplate
            self.defaultBranch = defaultBranch
            self.allowSquashMerge = allowSquashMerge
            self.allowMergeCommit = allowMergeCommit
            self.allowRebaseMerge = allowRebaseMerge
            self.allowAutoMerge = allowAutoMerge
            self.deleteBranchOnMerge = deleteBranchOnMerge
            self.archived = archived
            self.allowForking = allowForking
        }
        
        private enum CodingKeys: String, CodingKey {
            case name
            case description
            case homepage
            case `private`
            case visibility
            case hasIssues = "has_issues"
            case hasProjects = "has_projects"
            case hasWiki = "has_wiki"
            case isTemplate = "is_template"
            case defaultBranch = "default_branch"
            case allowSquashMerge = "allow_squash_merge"
            case allowMergeCommit = "allow_merge_commit"
            case allowRebaseMerge = "allow_rebase_merge"
            case allowAutoMerge = "allow_auto_merge"
            case deleteBranchOnMerge = "delete_branch_on_merge"
            case archived
            case allowForking = "allow_forking"
        }
    }
}

// MARK: - Delete

extension GitHub.Repositories {
    public enum Delete {}
}

extension GitHub.Repositories.Delete {
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
