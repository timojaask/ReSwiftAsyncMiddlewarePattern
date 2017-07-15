import PromiseKit

protocol DataService {
    func fetchUsers() -> Promise<[User]>
    func fetchPosts() -> Promise<[Post]>
    func createPost(post: Post) -> Promise<Void>
}
