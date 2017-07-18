import Quick
import Nimble
import ReSwift
@testable import ReSwiftAsyncMiddlewarePattern

class FetchUsersSpec: QuickSpec {

    override func spec() {
        describe("fetchUsers") {

            it("Does not call fetchUsers service when action is not FetchUsers") {
                let testDataService = TestDataService(
                    posts: [],
                    users: [],
                    shouldFail: false,
                    fetchUsersCallback: {
                        fail("The test was not supposed to call fetchUsers DataService method")
                    },
                    fetchPostsCallback: nil,
                    createPostCallback: nil
                )
                let middlewareItem = fetchUsers(dataService: testDataService)
                middlewareItem(FetchPosts.request) { _ in }
            }

            it("Does not call fetchUsers service when action is FetchUsers and type is not request") {
                let testDataService = TestDataService(
                    posts: [],
                    users: [],
                    shouldFail: false,
                    fetchUsersCallback: {
                        fail("The test was not supposed to call fetchUsers DataService method")
                    },
                    fetchPostsCallback: nil,
                    createPostCallback: nil
                )
                let middlewareItem = fetchUsers(dataService: testDataService)
                middlewareItem(FetchUsers.success(users: [])) { _ in }
            }

            it("Dispatches FetchUsers.success action with correct users after FetchUsers.request is passed") {
                let expected = randomUsers()
                let testDataService = TestDataService(posts: [], users: expected, shouldFail: false, fetchUsersCallback: nil, fetchPostsCallback: nil, createPostCallback: nil)
                let middlewareItem = fetchUsers(dataService: testDataService)

                var actual: [User] = []
                middlewareItem(FetchUsers.request) { action in
                    guard let action = action as? FetchUsers,
                        case .success(let fetchedUsers) = action else {
                            fail("Expected middleware to dispatch FetchUsers.success action")
                            return
                    }
                    actual = fetchedUsers
                }
                expect(actual).toEventually(equal(expected), timeout: 1)
            }

            it("Dispatches FetchUsers.error action if error occurs") {
                let testDataService = TestDataService(posts: [], users: [], shouldFail: true, fetchUsersCallback: nil, fetchPostsCallback: nil, createPostCallback: nil)
                let middlewareItem = fetchUsers(dataService: testDataService)

                let expected = TestDataServiceError.someError
                var actual: Error?
                middlewareItem(FetchUsers.request) { action in
                    guard let action = action as? FetchUsers,
                        case .failure(let error) = action else {
                            fail("Expected middleware to dispatch FetchUsers.failure action")
                            return
                    }
                    actual = error
                }
                expect(actual).toEventually(matchError(expected), timeout: 1)
            }
        }
    }
}
