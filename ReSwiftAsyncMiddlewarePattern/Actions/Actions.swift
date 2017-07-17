import ReSwift

enum FetchUsers: Action {
    case request
    case success(users: [User])
    case failure(error: Error)
}

enum FetchPosts: Action {
    case request
    case success(posts: [Post])
    case failure(error: Error)
}

enum CreatePost: Action {
    case request(post: Post)
    case success
    case failure(error: Error)
}
