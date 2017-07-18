import Quick
import Nimble
import ReSwift
@testable import ReSwiftAsyncMiddlewarePattern

class FetchPostsSpec: QuickSpec {

    override func spec() {
        describe("fetchPosts") {

            it("Does not call fetchPosts service when action is not FetchPosts") {
                let testDataService = TestDataService(fetchPostsCallback: {
                    fail("The test was not supposed to call fetchPosts DataService method")
                })
                let middlewareItem = fetchPosts(dataService: testDataService)
                middlewareItem(FetchUsers.request) { _ in }
            }

            it("Does not call fetchPosts service when action is FetchPosts and type is not request") {
                let testDataService = TestDataService(fetchPostsCallback: {
                    fail("The test was not supposed to call fetchPosts DataService method")
                })
                let middlewareItem = fetchPosts(dataService: testDataService)
                middlewareItem(FetchPosts.success(posts: [])) { _ in }
            }

            it("Dispatches FetchPosts.success action with correct posts after FetchPosts.request is passed") {
                let expected = randomPosts()
                let testDataService = TestDataService(posts: expected, users: [])
                let middlewareItem = fetchPosts(dataService: testDataService)

                var actual: [Post] = []
                middlewareItem(FetchPosts.request) { action in
                    guard let action = action as? FetchPosts,
                        case .success(let fetchedPosts) = action else {
                            fail("Expected middleware to dispatch FetchPosts.success action")
                            return
                    }
                    actual = fetchedPosts
                }
                expect(actual).toEventually(equal(expected), timeout: 1)
            }

            it("Dispatches FetchPosts.error action if error occurs") {
                let testDataService = TestDataService(shouldFail: true)
                let middlewareItem = fetchPosts(dataService: testDataService)

                let expected = TestDataServiceError.someError
                var actual: Error?
                middlewareItem(FetchPosts.request) { action in
                    guard let action = action as? FetchPosts,
                        case .failure(let error) = action else {
                            fail("Expected middleware to dispatch FetchPosts.failure action")
                            return
                    }
                    actual = error
                }
                expect(actual).toEventually(matchError(expected), timeout: 1)
            }
        }
    }
}
