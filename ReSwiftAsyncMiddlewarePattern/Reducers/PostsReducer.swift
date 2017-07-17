import ReSwift

func postsReducer(action: Action, state: AppState?) -> [Post] {
    let state = state ?? AppState()

    guard let action = action as? FetchPosts,
        case .success(let fetchedPosts) = action else {
            return state.posts
    }

    print("postsReducer reducer")

    return fetchedPosts
}
