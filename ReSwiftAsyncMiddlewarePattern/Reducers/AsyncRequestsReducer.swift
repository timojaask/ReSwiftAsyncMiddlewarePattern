import ReSwift

func asyncRequestsReducer(action: Action, state: AsyncRequests?) -> AsyncRequests {
    var state = state ?? AsyncRequests()
    switch action {
    case let action as SetCreatePost:
        state.createPost = action.state
    default:
        break
    }
    return state
}
