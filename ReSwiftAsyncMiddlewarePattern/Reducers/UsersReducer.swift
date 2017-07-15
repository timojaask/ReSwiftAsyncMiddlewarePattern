import ReSwift

func usersReducer(action: Action, state: AppState?) -> [User] {
    let state = state ?? AppState()

    guard let setFetchUsersAction = action as? SetFetchUsers,
        case .success(let fetchedUsers) = setFetchUsersAction.state else {
            return state.users
    }
    
    return fetchedUsers
}
