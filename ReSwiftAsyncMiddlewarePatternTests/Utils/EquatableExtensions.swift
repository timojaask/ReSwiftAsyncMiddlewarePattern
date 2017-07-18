@testable import ReSwiftAsyncMiddlewarePattern

extension AppState: Equatable { }
public func ==(lhs: AppState, rhs: AppState) -> Bool {
    return lhs.posts == rhs.posts && lhs.users == rhs.users
}

extension User: Equatable { }
public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
}

extension Post: Equatable { }
public func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.body == rhs.body && lhs.title == rhs.title
}
