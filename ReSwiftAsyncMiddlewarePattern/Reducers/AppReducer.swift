import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        users: usersReducer(action: action, state: state),
        posts: postsReducer(action: action, state: state),
        asyncRequests: asyncRequestsReducer(action: action, state: state?.asyncRequests)
    )
}
