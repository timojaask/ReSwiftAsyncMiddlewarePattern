import ReSwift

func usersReducer(action: Action, state: AppState?) -> [User] {
    let state = state ?? AppState()

    guard let action = action as? FetchUsers,
        case .success(let fetchedUsers) = action else {
            return state.users
    }

    print("usersReducer reducer")

    return fetchedUsers
}
