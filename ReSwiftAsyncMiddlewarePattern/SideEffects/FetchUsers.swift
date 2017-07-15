import ReSwift

func fetchUsers(dataService: DataService) -> SideEffect {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? SetFetchUsers,
            case .request = action.state else { return }

        print("fetchUsers side effect, state is: \(action.state)")

        dataService.fetchUsers()
            .then { dispatch(SetFetchUsers(state: .success(users: $0))) }
            .catch { dispatch(SetFetchUsers(state: .error(error: $0))) }
    }
}
