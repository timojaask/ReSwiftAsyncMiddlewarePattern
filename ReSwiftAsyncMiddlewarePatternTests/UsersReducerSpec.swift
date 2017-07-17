import Quick
import Nimble

class UsersReducerSpec: QuickSpec {

    override func spec() {
        describe("Users reducer") {

            it("Instantiates [User] state when passed state is nil") {
                let initialState: [User]? = nil
                let expectedState: [User] = []
                let actualState = usersReducer(action: FetchPosts.request, state: initialState)

                expect(actualState).to(equal(expectedState))
            }

            it("Leaves state unchanged if action is not FetchUsers") {
                let initialState = randomUsers()
                let expectedState = initialState
                let actualState = usersReducer(action: FetchPosts.success(posts: []), state: initialState)

                expect(actualState).to(equal(expectedState))
            }

            it("Leaves state unchanged if action is FetchUsers but not .success") {
                let initialState = randomUsers()
                let expectedState = initialState
                let actualState = usersReducer(action: FetchPosts.request, state: initialState)

                expect(actualState).to(equal(expectedState))
            }

            it("Returns new users on FetchUsers.success action") {
                let newUsers = randomUsers()
                let fetchUsersSuccessAction = FetchUsers.success(users: newUsers)

                let initialState = randomUsers()
                let expectedState = newUsers
                let actualState = usersReducer(action: fetchUsersSuccessAction, state: initialState)

                expect(actualState).to(equal(expectedState))
            }
        }
    }
}
