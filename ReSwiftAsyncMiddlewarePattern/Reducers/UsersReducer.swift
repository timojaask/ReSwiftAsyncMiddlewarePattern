import ReSwift

func usersReducer(action: Action, state: [User]?) -> [User] {
    let state = state ?? []

    guard let action = action as? FetchUsers,
        case .success(let fetchedUsers) = action else {
            return state
    }

    print("usersReducer reducer")

    return fetchedUsers
}
