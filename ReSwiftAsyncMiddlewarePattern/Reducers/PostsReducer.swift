import ReSwift

func postsReducer(action: Action, state: AppState?) -> [Post] {
    let state = state ?? AppState()

    guard let setFetchPostsAction = action as? SetFetchPosts,
        case .success(let fetchedPosts) = setFetchPostsAction.state else {
            return state.posts
    }

    return fetchedPosts
}
