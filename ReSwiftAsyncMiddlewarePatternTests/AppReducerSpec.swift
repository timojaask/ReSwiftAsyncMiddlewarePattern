import Quick
import Nimble

class AppReducerSpec: QuickSpec {

    override func spec() {
        describe("Users") {

            it("Sets users array when FetchUsers.success action is called") {
                let users = randomUsers()
                let initial = AppState()
                let action = FetchUsers.success(users: users)

                let expected = AppState(users: users, posts: [])
                let actual = appReducer(action: action, state: initial)

                expect(actual).to(equal(expected))
            }

            it("Sets posts array when FetchPosts.success action is called") {
                let posts = randomPosts()
                let initial = AppState()
                let action = FetchPosts.success(posts: posts)

                let expected = AppState(users: [], posts: posts)
                let actual = appReducer(action: action, state: initial)

                expect(actual).to(equal(expected))
            }
        }
    }
}
