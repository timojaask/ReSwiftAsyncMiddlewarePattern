import ReSwift

func postsReducer(action: Action, state: [Post]?) -> [Post] {
    let state = state ?? []

    guard let action = action as? FetchPosts,
        case .success(let fetchedPosts) = action else {
            return state
    }

    print("postsReducer reducer")

    return fetchedPosts
}
