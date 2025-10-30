import Foundation
@testable import GitHub_Types
@testable import GitHub_Repositories_Types
@testable import GitHub_Traffic_Types
@testable import GitHub_Stargazers_Types
@testable import GitHub_Types_Shared
import Testing
import Dependencies
import TypesFoundation

@Suite("README Code Examples Validation", .serialized)
struct ReadmeVerificationTests {

    // MARK: - Import Modules (README lines 36-40)

    @Test("Verify module imports compile")
    func moduleImportsExample() async throws {
        // This test verifies that the import statements in the README are correct
        // by using types from each module

        let _: GitHub.Client.Type = GitHub.Client.self
        let _: GitHub.Traffic.Client.Type = GitHub.Traffic.Client.self
        let _: GitHub.Repositories.Client.Type = GitHub.Repositories.Client.self
        let _: GitHub.Stargazers.Client.Type = GitHub.Stargazers.Client.self
    }

    // MARK: - Using Type-Safe Models (README lines 45-60)

    @Test("Traffic analytics response types (README lines 46-48)")
    func trafficAnalyticsResponseExample() async throws {
        let viewsResponse = GitHub.Traffic.Views.Response(
            count: 1000,
            uniques: 250,
            views: [
                GitHub.Traffic.Views.View(
                    timestamp: Date(),
                    count: 100,
                    uniques: 25
                )
            ]
        )

        #expect(viewsResponse.count == 1000)
        #expect(viewsResponse.uniques == 250)
    }

    @Test("Repository model types (README lines 51-53)")
    func repositoryModelExample() async throws {
        let repository = GitHub.Repository(
            id: .init(rawValue: 123),
            nodeId: "test-node-id",
            name: "test-repo",
            fullName: "user/test-repo",
            private: false,
            owner: GitHub.Owner(
                id: .init(rawValue: 456),
                login: "user",
                nodeId: "owner-node-id",
                avatarUrl: URL(string: "https://github.com/avatar")!,
                gravatarId: "",
                url: URL(string: "https://api.github.com/users/user")!,
                htmlUrl: URL(string: "https://github.com/user")!,
                type: "User",
                siteAdmin: false
            ),
            htmlUrl: URL(string: "https://github.com/user/test-repo")!,
            description: "Test repo",
            fork: false,
            url: URL(string: "https://api.github.com/repos/user/test-repo")!,
            createdAt: Date(),
            updatedAt: Date(),
            pushedAt: Date(),
            size: 100,
            stargazersCount: 50,
            watchersCount: 25,
            language: "Swift",
            hasIssues: true,
            hasProjects: true,
            hasDownloads: true,
            hasWiki: true,
            hasPages: false,
            forksCount: 10,
            archived: false,
            disabled: false,
            openIssuesCount: 5,
            license: nil,
            allowForking: true,
            isTemplate: false,
            topics: [],
            visibility: "public",
            defaultBranch: "main"
        )

        #expect(repository.fullName == "user/test-repo")
        #expect(repository.stargazersCount == 50)
    }

    @Test("Stargazers list response types (README lines 56-59)")
    func stargazersListResponseExample() async throws {
        let stargazers: GitHub.Stargazers.List.Response = [
            GitHub.Stargazers.List.Stargazer(
                user: GitHub.User(
                    login: "user1",
                    id: 123,
                    nodeId: "node-123",
                    avatarUrl: "https://github.com/avatar1",
                    gravatarId: nil,
                    url: "https://api.github.com/users/user1",
                    htmlUrl: "https://github.com/user1",
                    type: "User",
                    siteAdmin: false
                ),
                starredAt: Date()
            )
        ]

        #expect(stargazers.count == 1)
        #expect(stargazers[0].user.login == "user1")
    }

    // MARK: - Repositories: List User Repositories (README lines 72-84)

    @Test("List user repositories request (README lines 72-84)")
    func listUserRepositoriesExample() async throws {
        let listRequest = GitHub.Repositories.List.Request(
            visibility: .public,
            type: .owner,
            sort: .updated,
            direction: .desc,
            perPage: 30,
            page: 1
        )

        #expect(listRequest.visibility == .public)
        #expect(listRequest.type == .owner)
        #expect(listRequest.sort == .updated)
        #expect(listRequest.direction == .desc)
        #expect(listRequest.perPage == 30)
        #expect(listRequest.page == 1)
    }

    // MARK: - Repositories: Create a Repository (README lines 89-102)

    @Test("Create repository request (README lines 89-102)")
    func createRepositoryExample() async throws {
        let createRequest = GitHub.Repositories.Create.Request(
            name: "my-new-repo",
            description: "A Swift package for awesome things",
            private: false,
            hasIssues: true,
            hasWiki: true,
            autoInit: true,
            gitignoreTemplate: "Swift",
            licenseTemplate: "apache-2.0"
        )

        #expect(createRequest.name == "my-new-repo")
        #expect(createRequest.description == "A Swift package for awesome things")
        #expect(createRequest.private == false)
        #expect(createRequest.hasIssues == true)
        #expect(createRequest.hasWiki == true)
        #expect(createRequest.autoInit == true)
        #expect(createRequest.gitignoreTemplate == "Swift")
        #expect(createRequest.licenseTemplate == "apache-2.0")
    }

    // MARK: - Repositories: Update Repository Settings (README lines 117-130)

    @Test("Update repository request (README lines 117-130)")
    func updateRepositoryExample() async throws {
        let updateRequest = GitHub.Repositories.Update.Request(
            description: "Updated description",
            private: true,
            hasIssues: true,
            defaultBranch: "main"
        )

        #expect(updateRequest.description == "Updated description")
        #expect(updateRequest.private == true)
        #expect(updateRequest.hasIssues == true)
        #expect(updateRequest.defaultBranch == "main")
    }

    // MARK: - Repositories: Delete a Repository (README lines 135-140)

    @Test("Delete repository response type (README lines 135-140)")
    func deleteRepositoryExample() async throws {
        let response = GitHub.Repositories.Delete.Response(
            message: "Repository deleted",
            documentationUrl: nil
        )

        #expect(response.message == "Repository deleted")
        #expect(response.documentationUrl == nil)
    }

    // MARK: - Traffic Analytics: Get Repository Views (README lines 149-161)

    @Test("Get repository views response (README lines 149-161)")
    func getRepositoryViewsExample() async throws {
        let viewsResponse = GitHub.Traffic.Views.Response(
            count: 1500,
            uniques: 300,
            views: [
                GitHub.Traffic.Views.View(
                    timestamp: Date(),
                    count: 150,
                    uniques: 30
                ),
                GitHub.Traffic.Views.View(
                    timestamp: Date().addingTimeInterval(-86400),
                    count: 200,
                    uniques: 40
                )
            ]
        )

        #expect(viewsResponse.count == 1500)
        #expect(viewsResponse.uniques == 300)
        #expect(viewsResponse.views.count == 2)
        #expect(viewsResponse.views[0].count == 150)
    }

    // MARK: - Traffic Analytics: Get Clone Statistics (README lines 166-174)

    @Test("Get clone statistics response (README lines 166-174)")
    func getClonesExample() async throws {
        let clonesResponse = GitHub.Traffic.Clones.Response(
            count: 500,
            uniques: 100,
            clones: [
                GitHub.Traffic.Clones.Clone(
                    timestamp: Date(),
                    count: 50,
                    uniques: 10
                )
            ]
        )

        #expect(clonesResponse.count == 500)
        #expect(clonesResponse.uniques == 100)
        #expect(clonesResponse.clones.count == 1)
    }

    // MARK: - Traffic Analytics: Get Top Referral Paths (README lines 179-187)

    @Test("Get top referral paths response (README lines 179-187)")
    func getTopPathsExample() async throws {
        let pathsResponse = GitHub.Traffic.Paths.Response(
            paths: [
                GitHub.Traffic.Paths.Path(
                    path: "/coenttb/swift-github-types",
                    title: "coenttb/swift-github-types",
                    count: 250,
                    uniques: 50
                ),
                GitHub.Traffic.Paths.Path(
                    path: "/coenttb/swift-github-types/README.md",
                    title: "swift-github-types/README.md",
                    count: 100,
                    uniques: 25
                )
            ]
        )

        #expect(pathsResponse.paths.count == 2)
        #expect(pathsResponse.paths[0].path == "/coenttb/swift-github-types")
        #expect(pathsResponse.paths[0].count == 250)
    }

    // MARK: - Traffic Analytics: Get Top Referral Sources (README lines 192-200)

    @Test("Get top referral sources response (README lines 192-200)")
    func getTopReferrersExample() async throws {
        let referrersResponse = GitHub.Traffic.Referrers.Response(
            referrers: [
                GitHub.Traffic.Referrers.Referrer(
                    referrer: "github.com",
                    count: 500,
                    uniques: 100
                ),
                GitHub.Traffic.Referrers.Referrer(
                    referrer: "google.com",
                    count: 300,
                    uniques: 60
                )
            ]
        )

        #expect(referrersResponse.referrers.count == 2)
        #expect(referrersResponse.referrers[0].referrer == "github.com")
        #expect(referrersResponse.referrers[0].count == 500)
    }

    // MARK: - Stargazers (README lines 207-221)

    @Test("List stargazers request (README lines 207-221)")
    func listStargazersExample() async throws {
        let request = GitHub.Stargazers.List.Request(
            perPage: 100,
            page: 1
        )

        #expect(request.perPage == 100)
        #expect(request.page == 1)

        // Verify stargazer response structure
        let stargazer = GitHub.Stargazers.List.Stargazer(
            user: GitHub.User(
                login: "testuser",
                id: 789,
                nodeId: "node-789",
                avatarUrl: "https://github.com/avatar",
                gravatarId: nil,
                url: "https://api.github.com/users/testuser",
                htmlUrl: "https://github.com/testuser",
                type: "User",
                siteAdmin: false
            ),
            starredAt: Date()
        )

        #expect(stargazer.user.login == "testuser")
    }

    // MARK: - Architecture: Type Organization (README lines 240-257)

    @Test("Verify type organization structure (README lines 240-257)")
    func typeOrganizationExample() async throws {
        // Verify that GitHub namespace contains feature enums (not structs as shown in old README)
        let _: GitHub.Repositories.Type = GitHub.Repositories.self
        let _: GitHub.Traffic.Type = GitHub.Traffic.self

        // Verify nested operation namespaces exist
        let _: GitHub.Repositories.List.Type = GitHub.Repositories.List.self
        let _: GitHub.Repositories.Create.Type = GitHub.Repositories.Create.self
        let _: GitHub.Repositories.Update.Type = GitHub.Repositories.Update.self

        // Verify Request/Response types
        let _: GitHub.Repositories.List.Request.Type = GitHub.Repositories.List.Request.self
        let _: GitHub.Repositories.List.Response.Type = GitHub.Repositories.List.Response.self
    }

    // MARK: - Client Structure (README lines 262-285)

    @Test("Verify client structure (README lines 262-285)")
    func clientStructureExample() async throws {
        // Verify feature-specific clients exist
        let _: GitHub.Repositories.Client.Type = GitHub.Repositories.Client.self
        let _: GitHub.Traffic.Client.Type = GitHub.Traffic.Client.self
        let _: GitHub.Stargazers.Client.Type = GitHub.Stargazers.Client.self

        // Verify main GitHub client structure
        let _: GitHub.Client.Type = GitHub.Client.self

        // Verify the main client has all sub-clients as properties
        let client = GitHub.Client(
            traffic: GitHub.Traffic.Client(),
            repositories: GitHub.Repositories.Client(),
            stargazers: GitHub.Stargazers.Client(),
            oauth: GitHub.OAuth.Client(),
            collaborators: GitHub.Collaborators.Client()
        )

        let _: GitHub.Traffic.Client = client.traffic
        let _: GitHub.Repositories.Client = client.repositories
    }

    // MARK: - Testing: Mock Client (README lines 297-378)

    @Test("Mock client testing (README lines 297-378)")
    func mockClientTestingExample() async throws {
        // Create mock repository data (exactly as shown in README)
        let mockRepo = GitHub.Repository(
            id: .init(rawValue: 123),
            nodeId: "MDEwOlJlcG9zaXRvcnkxMjM=",
            name: "test-repo",
            fullName: "user/test-repo",
            private: false,
            owner: GitHub.Owner(
                id: .init(rawValue: 456),
                login: "user",
                nodeId: "MDQ6VXNlcjQ1Ng==",
                avatarUrl: URL(string: "https://github.com/avatar")!,
                gravatarId: "",
                url: URL(string: "https://api.github.com/users/user")!,
                htmlUrl: URL(string: "https://github.com/user")!,
                type: "User",
                siteAdmin: false
            ),
            htmlUrl: URL(string: "https://github.com/user/test-repo")!,
            description: "Test repository",
            fork: false,
            url: URL(string: "https://api.github.com/repos/user/test-repo")!,
            createdAt: Date(),
            updatedAt: Date(),
            pushedAt: Date(),
            size: 100,
            stargazersCount: 5,
            watchersCount: 3,
            language: "Swift",
            hasIssues: true,
            hasProjects: true,
            hasDownloads: true,
            hasWiki: true,
            hasPages: false,
            forksCount: 2,
            archived: false,
            disabled: false,
            openIssuesCount: 1,
            license: nil,
            allowForking: true,
            isTemplate: false,
            topics: ["swift", "testing"],
            visibility: "public",
            defaultBranch: "main"
        )

        // Create mock client (exactly as shown in README)
        let client = GitHub.Repositories.Client(
            list: { request in
                #expect(request?.type == .owner)
                return [mockRepo]
            },
            get: { owner, repo in
                #expect(owner == "user")
                #expect(repo == "test-repo")
                return mockRepo
            },
            create: { request in
                #expect(request.name == "new-repo")
                return mockRepo
            },
            update: { owner, repo, request in
                return mockRepo
            },
            delete: { owner, repo in
                return GitHub.Repositories.Delete.Response(
                    message: "Repository deleted",
                    documentationUrl: nil
                )
            }
        )

        // Test list operation (exactly as shown in README)
        let repos = try await client.list(GitHub.Repositories.List.Request(type: .owner))
        #expect(repos.count == 1)
        #expect(repos[0].name == "test-repo")

        // Test get operation (exactly as shown in README)
        let repo = try await client.get(owner: "user", repo: "test-repo")
        #expect(repo.fullName == "user/test-repo")
    }

    // MARK: - API Routes (README lines 386-398)

    @Test("API router URL generation (README lines 386-398)")
    func apiRoutesExample() async throws {
        let router = GitHub.Repositories.API.Router()

        // Test list endpoint URL
        let listAPI = GitHub.Repositories.API.list(request: nil)
        let listURL = router.url(for: listAPI)
        #expect(listURL.path == "/user/repos")

        // Test get endpoint URL
        let getAPI = GitHub.Repositories.API.get(owner: "coenttb", repo: "swift-github-types")
        let getURL = router.url(for: getAPI)
        #expect(getURL.path == "/repos/coenttb/swift-github-types")
    }

    // MARK: - Type Conformance Validation

    @Test("Verify all types conform to required protocols")
    func typeConformanceValidation() async throws {
        // Verify Request types conform to Codable, Equatable, Sendable
        let listRequest = GitHub.Repositories.List.Request()
        let _: any Codable = listRequest
        let _: any Equatable = listRequest
        let _: any Sendable = listRequest

        let createRequest = GitHub.Repositories.Create.Request(name: "test")
        let _: any Codable = createRequest
        let _: any Equatable = createRequest
        let _: any Sendable = createRequest

        // Verify Response types conform
        let repository = GitHub.Repository(
            id: .init(rawValue: 1),
            nodeId: "node",
            name: "name",
            fullName: "full/name",
            private: false,
            owner: GitHub.Owner(
                id: .init(rawValue: 2),
                login: "login",
                nodeId: "node",
                avatarUrl: URL(string: "https://example.com")!,
                gravatarId: "",
                url: URL(string: "https://example.com")!,
                htmlUrl: URL(string: "https://example.com")!,
                type: "User",
                siteAdmin: false
            ),
            htmlUrl: URL(string: "https://example.com")!,
            description: nil,
            fork: false,
            url: URL(string: "https://example.com")!,
            createdAt: Date(),
            updatedAt: Date(),
            pushedAt: nil,
            size: 0,
            stargazersCount: 0,
            watchersCount: 0,
            language: nil,
            hasIssues: false,
            hasProjects: false,
            hasDownloads: false,
            hasWiki: false,
            hasPages: false,
            forksCount: 0,
            archived: false,
            disabled: false,
            openIssuesCount: 0,
            license: nil,
            allowForking: false,
            isTemplate: false,
            topics: [],
            visibility: "public",
            defaultBranch: "main"
        )
        let _: any Codable = repository
        let _: any Equatable = repository
        let _: any Sendable = repository
    }

    @Test("Verify client protocols are properly defined")
    func clientProtocolValidation() async throws {
        // Verify all client types exist and have expected structure
        let _: GitHub.Repositories.Client.Type = GitHub.Repositories.Client.self
        let _: GitHub.Traffic.Client.Type = GitHub.Traffic.Client.self
        let _: GitHub.Stargazers.Client.Type = GitHub.Stargazers.Client.self
        let _: GitHub.Client.Type = GitHub.Client.self
    }
}
