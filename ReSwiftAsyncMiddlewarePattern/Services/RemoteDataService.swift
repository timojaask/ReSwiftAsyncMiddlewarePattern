import PromiseKit

struct RemoteDataService: DataService {
    private static var posts = [
        Post(title: "Post One", body: "Body of post one."),
        Post(title: "Post Two", body: "Body of post two."),
        Post(title: "Post Three", body: "Body of post three."),
    ]

    private static let users = [
        User(firstName: "User", lastName: "One"),
        User(firstName: "User", lastName: "Two"),
        User(firstName: "User", lastName: "Three"),
    ]

    private static func executeWithDelay(closure: @escaping () -> ()) {
        let artificialDelaySeconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + artificialDelaySeconds) {
            closure()
        }
    }

    func fetchUsers() -> Promise<[User]> {
        return Promise<[User]> { fulfill, reject in
            RemoteDataService.executeWithDelay {
                fulfill(RemoteDataService.users)
            }
        }
    }

    func fetchPosts() -> Promise<[Post]> {
        return Promise<[Post]> { fulfill, reject in
            RemoteDataService.executeWithDelay {
                fulfill(RemoteDataService.posts)
            }
        }
    }

    func createPost(post: Post) -> Promise<Void> {
        return Promise<Void> { fulfill, reject in
            RemoteDataService.executeWithDelay {
                RemoteDataService.posts.append(post)
                fulfill()
            }
        }
    }
}
