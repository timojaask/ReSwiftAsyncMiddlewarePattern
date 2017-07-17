import ReSwift

func usersReducer(action: Action, state: AppState?) -> [User] {
    let state = state ?? AppState()

    guard let action = action as? FetchUsersSuccess else {
        return state.users
    }

    return action.users
}
