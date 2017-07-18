import Quick
import Nimble
@testable import ReSwiftAsyncMiddlewarePattern

class AppReducerSpec: QuickSpec {

    override func spec() {
        describe("Reducer") {

            it("Sets users array when FetchUsers.success action is called, keeping other state unchanged") {
                let newUsers = randomUsers()
                let fetchUsersSuccessAction = FetchUsers.success(users: newUsers)

                let initialState = randomAppState()
                let expectedState = AppState(users: newUsers, posts: initialState.posts)
                let actualState = appReducer(action: fetchUsersSuccessAction, state: initialState)

                expect(actualState).to(equal(expectedState))
            }

            it("Sets posts array when FetchPosts.success action is called, keeping other state unchanged") {
                let newPosts = randomPosts()
                let fetchPostsSuccessAction = FetchPosts.success(posts: newPosts)

                let initialState = randomAppState()
                let expectedState = AppState(users: initialState.users, posts: newPosts)
                let actualState = appReducer(action: fetchPostsSuccessAction, state: initialState)

                expect(actualState).to(equal(expectedState))
            }
        }
    }
}
