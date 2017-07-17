import ReSwift

struct FetchUsersRequest: Action { }
struct FetchUsersSuccess: Action { let users: [User] }
struct FetchUsersFailure: Action { let error: Error }

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
