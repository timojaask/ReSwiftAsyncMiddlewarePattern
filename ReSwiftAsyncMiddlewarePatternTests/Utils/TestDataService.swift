import PromiseKit
@testable import ReSwiftAsyncMiddlewarePattern

enum TestDataServiceError: Error {
    case someError
}

struct TestDataService: DataService {
    let posts: [Post]
    let users: [User]
    let shouldFail: Bool
    let fetchUsersCallback: (() -> Void)?
    let fetchPostsCallback: (() -> Void)?
    let createPostCallback: (() -> Void)?

    init(shouldFail: Bool) {
        self.init(posts: [], users: [], shouldFail: shouldFail, fetchUsersCallback: nil, fetchPostsCallback: nil, createPostCallback: nil)
    }

    init(posts: [Post], users: [User]) {
        self.init(posts: posts, users: users, shouldFail: false, fetchUsersCallback: nil, fetchPostsCallback: nil, createPostCallback: nil)
    }

    init(fetchUsersCallback: (() -> Void)?) {
        self.init(posts: [], users: [], shouldFail: false, fetchUsersCallback: fetchUsersCallback, fetchPostsCallback: nil, createPostCallback: nil)
    }

    init(fetchPostsCallback: (() -> Void)?) {
        self.init(posts: [], users: [], shouldFail: false, fetchUsersCallback: nil, fetchPostsCallback: fetchPostsCallback, createPostCallback: nil)
    }

    init(createPostCallback: (() -> Void)?) {
        self.init(posts: [], users: [], shouldFail: false, fetchUsersCallback: nil, fetchPostsCallback: nil, createPostCallback: createPostCallback)
    }

    init(posts: [Post], users: [User], shouldFail: Bool, fetchUsersCallback: (() -> Void)?, fetchPostsCallback: (() -> Void)?, createPostCallback: (() -> Void)?) {
        self.posts = posts
        self.users = users
        self.shouldFail = shouldFail
        self.fetchUsersCallback = fetchUsersCallback
        self.fetchPostsCallback = fetchPostsCallback
        self.createPostCallback = createPostCallback
    }

    func fetchPosts() -> Promise<[Post]> {
        self.fetchPostsCallback?()
        return promise(shouldFail: self.shouldFail) { $0(self.posts) }
    }

    func fetchUsers() -> Promise<[User]> {
        self.fetchUsersCallback?()
        return promise(shouldFail: self.shouldFail) { $0(self.users) }
    }

    func createPost(post: Post) -> Promise<Void> {
        self.createPostCallback?()
        return promise(shouldFail: self.shouldFail) { $0() }
    }

    private func promise<T>(shouldFail: Bool, _ fulfillCall: (_ fulfill: (T) -> Void) -> Void) -> Promise<T> {
        return Promise { (fulfill, reject) in
            guard !shouldFail else {
                reject(TestDataServiceError.someError)
                return
            }
            fulfillCall(fulfill)
        }
    }
}
