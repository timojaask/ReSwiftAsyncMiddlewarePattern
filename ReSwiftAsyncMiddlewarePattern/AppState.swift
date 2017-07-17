import ReSwift

struct AsyncRequests: StateType {
    var fetchPosts = FetchPosts.none
    var createPost = CreatePost.none
}

struct AppState: StateType {
    var users: [User] = []
    var posts: [Post] = []
    var asyncRequests = AsyncRequests()
}
