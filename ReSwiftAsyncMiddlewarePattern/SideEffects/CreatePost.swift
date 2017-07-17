import ReSwift

func createPost(dataService: DataService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? CreatePost,
            case .request(let post) = action else { return }

        print("createPost side effect")

        dataService.createPost(post: post)
            .then { dispatch(CreatePost.success) }
            .catch { dispatch(CreatePost.failure(error: $0)) }
    }
}
