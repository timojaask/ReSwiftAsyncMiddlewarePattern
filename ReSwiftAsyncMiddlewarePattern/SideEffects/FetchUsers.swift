import ReSwift

func fetchUsers(dataService: DataService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? FetchUsers,
            case .request = action else { return }

        print("fetchUsers side effect")

        dataService.fetchUsers()
            .then { dispatch(FetchUsers.success(users: $0)) }
            .catch { dispatch(FetchUsers.failure(error: $0)) }
    }
}
