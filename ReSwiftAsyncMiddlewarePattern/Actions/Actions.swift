import ReSwift

enum CreatePost {
    case none
    case request(post: Post)
    case success()
    case error(error: Error)
}

struct SetCreatePost: Action { let state: CreatePost }


struct FetchUsersRequest: Action { }
struct FetchUsersSuccess: Action { let users: [User] }
struct FetchUsersFailure: Action { let error: Error }

enum FetchPosts: Action {
    case request
    case success(posts: [Post])
    case failure(error: Error)
}
