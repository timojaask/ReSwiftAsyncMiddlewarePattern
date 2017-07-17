extension AppState: Equatable { }
func ==(lhs: AppState, rhs: AppState) -> Bool {
    return lhs.posts == rhs.posts && lhs.users == rhs.users
}

extension User: Equatable { }
func ==(lhs: User, rhs: User) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
}

extension Post: Equatable { }
func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.body == rhs.body && lhs.title == rhs.title
}
