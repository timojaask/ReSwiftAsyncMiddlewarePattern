import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    print("appReducer with action: \(action)")
    return AppState(
        users: usersReducer(action: action, state: state?.users),
        posts: postsReducer(action: action, state: state?.posts)
    )
}
