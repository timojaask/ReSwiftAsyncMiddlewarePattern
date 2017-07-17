import ReSwift

struct AsyncRequests: StateType {
    var createPost = CreatePost.none
}

struct AppState: StateType {
    var users: [User] = []
    var posts: [Post] = []
    var asyncRequests = AsyncRequests()
}
