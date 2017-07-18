import Quick
import Nimble
@testable import ReSwiftAsyncMiddlewarePattern

class PostsReducerSpec: QuickSpec {

    override func spec() {
        describe("Posts reducer") {

            it("Instantiates [Post] when passed state is nil") {
                let initialState: [Post]? = nil
                let expectedState: [Post] = []
                let actualState = postsReducer(action: FetchUsers.request, state: initialState)

                expect(actualState).to(equal(expectedState))
            }

            it("Leaves state unchanged if action is not FetchPosts") {
                let initialState = randomPosts()
                let expectedState = initialState
                let actualState = postsReducer(action: FetchUsers.success(users: []), state: initialState)

                expect(actualState).to(equal(expectedState))
            }

            it("Leaves state unchanged if action is FetchPosts but not .success") {
                let initialState = randomPosts()
                let expectedState = initialState
                let actualState = postsReducer(action: FetchPosts.request, state: initialState)

                expect(actualState).to(equal(expectedState))
            }

            it("Returns new posts on FetchPosts.success action") {
                let newPosts = randomPosts()
                let fetchPostsSuccessAction = FetchPosts.success(posts: newPosts)

                let initialState = randomPosts()
                let expectedState = newPosts
                let actualState = postsReducer(action: fetchPostsSuccessAction, state: initialState)
                
                expect(actualState).to(equal(expectedState))
            }
        }
    }
}
