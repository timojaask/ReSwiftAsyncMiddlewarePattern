import ReSwift

enum FetchPosts {
    case none
    case request
    case success(posts: [Post])
    case error(error: Error)
}

enum CreatePost {
    case none
    case request(post: Post)
    case success()
    case error(error: Error)
}

struct SetFetchPosts: Action { let state: FetchPosts }
struct SetCreatePost: Action { let state: CreatePost }


struct FetchUsersRequest: Action { }
struct FetchUsersSuccess: Action { let users: [User] }
struct FetchUsersFailure: Action { let error: Error }
