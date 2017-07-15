import ReSwift

func createPost(dataService: DataService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? SetCreatePost,
            case .request(let post) = action.state else { return }

        print("createPost side effect, state is: \(action.state)")
        print("    post is: \(post)")

        dataService.createPost(post: post)
            .then { dispatch(SetCreatePost(state: .success())) }
            .catch { dispatch(SetCreatePost(state: .error(error: $0))) }
    }
}
