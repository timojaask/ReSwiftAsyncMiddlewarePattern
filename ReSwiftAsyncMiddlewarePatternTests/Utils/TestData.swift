@testable import ReSwiftAsyncMiddlewarePattern

func randomPost() -> Post {
    return Post(title: String.random(length: 5), body: String.random(length: 5))
}

func randomUser() -> User {
    return User(firstName: String.random(length: 5), lastName: String.random(length: 5))
}

func randomUsers(_ number: Int = 4) -> [User] {
    return (0..<number).map { _ in randomUser() }
}

func randomPosts(_ number: Int = 4) -> [Post] {
    return (0..<number).map { _ in randomPost() }
}

func randomAppState() -> AppState {
    return AppState(users: randomUsers(), posts: randomPosts())
}
