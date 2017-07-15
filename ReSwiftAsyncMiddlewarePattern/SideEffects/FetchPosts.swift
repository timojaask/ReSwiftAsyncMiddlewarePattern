import ReSwift

func fetchPosts(dataService: DataService) -> SideEffect {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? SetFetchPosts,
            case .request = action.state else { return }

        print("fetchUsers side effect, state is: \(action.state)")

        dataService.fetchPosts()
            .then { dispatch(SetFetchPosts(state: .success(posts: $0))) }
            .catch { dispatch(SetFetchPosts(state: .error(error: $0))) }
    }
}
