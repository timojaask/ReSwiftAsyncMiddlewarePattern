import Quick
import Nimble
import ReSwift
@testable import ReSwiftAsyncMiddlewarePattern

class CreatePostSpec: QuickSpec {

    override func spec() {
        describe("createPost") {

            it("Does not call createPost service when action is not CreatePost") {
                let testDataService = TestDataService(
                    posts: [],
                    users: [],
                    shouldFail: false,
                    fetchUsersCallback: nil,
                    fetchPostsCallback: nil,
                    createPostCallback: {
                        fail("The test was not supposed to call createPost DataService method")
                    }
                )
                let middlewareItem = createPost(dataService: testDataService)
                middlewareItem(FetchPosts.request) { _ in }
            }

            it("Does not call createPost service when action is CreatePost and type is not request") {
                let testDataService = TestDataService(
                    posts: [],
                    users: [],
                    shouldFail: false,
                    fetchUsersCallback: nil,
                    fetchPostsCallback: nil,
                    createPostCallback: {
                        fail("The test was not supposed to call createPost DataService method")
                    }
                )
                let middlewareItem = createPost(dataService: testDataService)
                middlewareItem(CreatePost.success) { _ in }
            }

            it("Dispatches CreatePost.success action after CreatePost.request is passed") {
                let testDataService = TestDataService(posts: [], users: [], shouldFail: false, fetchUsersCallback: nil, fetchPostsCallback: nil, createPostCallback: nil)
                let middlewareItem = createPost(dataService: testDataService)
                let newPost = randomPost()

                var successActionDispatched = false
                middlewareItem(CreatePost.request(post: newPost)) { action in
                    guard let action = action as? CreatePost,
                        case .success = action else {
                            fail("Expected middleware to dispatch CreatePost.success action")
                            return
                    }
                    successActionDispatched = true
                }
                expect(successActionDispatched).toEventually(beTrue(), timeout: 1)
            }

            it("Dispatches CreatePost.error action if error occurs") {
                let testDataService = TestDataService(posts: [], users: [], shouldFail: true, fetchUsersCallback: nil, fetchPostsCallback: nil, createPostCallback: nil)
                let middlewareItem = createPost(dataService: testDataService)
                let newPost = randomPost()

                let expected = TestDataServiceError.someError
                var actual: Error?
                middlewareItem(CreatePost.request(post: newPost)) { action in
                    guard let action = action as? CreatePost,
                        case .failure(let error) = action else {
                            fail("Expected middleware to dispatch CreatePost.failure action")
                            return
                    }
                    actual = error
                }
                expect(actual).toEventually(matchError(expected), timeout: 1)
            }
        }
    }
}
