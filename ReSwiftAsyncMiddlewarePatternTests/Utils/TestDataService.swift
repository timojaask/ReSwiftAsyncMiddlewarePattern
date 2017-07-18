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

    func fetchPosts() -> Promise<[Post]> {
        return promise(shouldFail: self.shouldFail) { $0(self.posts) }
    }

    func fetchUsers() -> Promise<[User]> {
        if let fetchUsersCallback = self.fetchUsersCallback {
            fetchUsersCallback()
        }
        return promise(shouldFail: self.shouldFail) { $0(self.users) }
    }

    func createPost(post: Post) -> Promise<Void> {
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
