import PromiseKit

struct RemoteDataService: DataService {
    func fetchUsers() -> Promise<[User]> {
        return Promise<[User]> { fulfill, reject in
            FakeRemoteService.executeWithDelay {
                fulfill(FakeRemoteService.users)
            }
        }
    }

    func fetchPosts() -> Promise<[Post]> {
        return Promise<[Post]> { fulfill, reject in
            FakeRemoteService.executeWithDelay {
                fulfill(FakeRemoteService.posts)
            }
        }
    }

    func createPost(post: Post) -> Promise<Void> {
        return Promise<Void> { fulfill, reject in
            FakeRemoteService.executeWithDelay {
                FakeRemoteService.posts.append(post)
                fulfill()
            }
        }
    }
}

fileprivate struct FakeRemoteService {
    static var posts = [
        Post(title: "Post One", body: "Body of post one."),
        Post(title: "Post Two", body: "Body of post two."),
        Post(title: "Post Three", body: "Body of post three."),
        ]

    static let users = [
        User(firstName: "User", lastName: "One"),
        User(firstName: "User", lastName: "Two"),
        User(firstName: "User", lastName: "Three"),
        ]

    static func executeWithDelay(closure: @escaping () -> ()) {
        let artificialDelaySeconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + artificialDelaySeconds) {
            closure()
        }
    }
}
