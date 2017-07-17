import ReSwift

func fetchPosts(dataService: DataService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? FetchPosts,
            case .request = action else { return }

        print("fetchPosts side effect")

        dataService.fetchPosts()
            .then { dispatch(FetchPosts.success(posts: $0)) }
            .catch { dispatch(FetchPosts.failure(error: $0)) }
    }
}
