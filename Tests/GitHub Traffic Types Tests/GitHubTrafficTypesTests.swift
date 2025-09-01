import Testing
import GitHub_Traffic_Types

@Suite("GitHub Traffic Types Tests")
struct GitHubTrafficTypesTests {
    @Test("Traffic API router generates correct URLs")
    func testTrafficAPIRoutes() throws {
        let router = GitHub.Traffic.API.Router()
        
        // Test views endpoint
        let viewsAPI = GitHub.Traffic.API.views(owner: "coenttb", repo: "swift-github-types", per: .day)
        let viewsURL = router.url(for: viewsAPI)
        #expect(viewsURL.path == "/repos/coenttb/swift-github-types/traffic/views")
        #expect(viewsURL.query == "per=day")
        
        // Test clones endpoint
        let clonesAPI = GitHub.Traffic.API.clones(owner: "coenttb", repo: "swift-github-types", per: .week)
        let clonesURL = router.url(for: clonesAPI)
        #expect(clonesURL.path == "/repos/coenttb/swift-github-types/traffic/clones")
        #expect(clonesURL.query == "per=week")
        
        // Test paths endpoint
        let pathsAPI = GitHub.Traffic.API.paths(owner: "coenttb", repo: "swift-github-types")
        let pathsURL = router.url(for: pathsAPI)
        #expect(pathsURL.path == "/repos/coenttb/swift-github-types/traffic/popular/paths")
        
        // Test referrers endpoint
        let referrersAPI = GitHub.Traffic.API.referrers(owner: "coenttb", repo: "swift-github-types")
        let referrersURL = router.url(for: referrersAPI)
        #expect(referrersURL.path == "/repos/coenttb/swift-github-types/traffic/popular/referrers")
    }
}