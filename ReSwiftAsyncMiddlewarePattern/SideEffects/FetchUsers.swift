import ReSwift

func fetchUsers(dataService: DataService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard action is FetchUsersRequest else { return }

        print("fetchUsers side effect")

        dataService.fetchUsers()
            .then { dispatch(FetchUsersSuccess(users: $0)) }
            .catch { dispatch(FetchUsersFailure(error: $0)) }
    }
}
