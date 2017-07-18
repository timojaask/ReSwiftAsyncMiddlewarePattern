# ReSwiftAsyncMiddlewarePattern
Example of writing fully unit testable asynchronous requests using [ReSwift](https://github.com/reswift/reswift) using middleware. In this pattern the side effects are handled outside of core application logic, so action creators and reducers are side effect free.

*In this context "side effect" means any call to an external service, be it Alamofire, UserDefaults or UIKit.*

## Problem
ReSwift documentation suggests to fire asynchronous operations directcly from within action creators:

```swift
func fetchGitHubRepositories(state: State, store: Store<State>) -> Action? {
    guard case let .LoggedIn(configuration) = state.authenticationState.loggedInState  else { return nil }

    Octokit(configuration).repositories { response in
        dispatch_async(dispatch_get_main_queue()) {
            store.dispatch(SetRepostories(repositories: .Repositories(response)))
        }
    }

    return SetRepositories(repositories: .Loading)
}
```

This makes it difficult to test action creators, as it is not clear how to replace `Octokit` object with a test stub. You could inject dependencies by wrapping action creators in a function that provides the required service, however then it would still feel like the action is doing too many things. It would be preferable for an `Action` to have only one purpose - describing an action. So ideally we want to call third party services somewhere outside of our actions and reducers.

## Solution
Instead of firing asynchronous operations from within action creators, we can use a ReSwift middleware, whose only job will be handling side effects:

```swift
// SideEffects/fetchUsers.swift
func fetchUsers(action: Action, dispatch: @escaping DispatchFunction) {
    guard let action = action as? FetchUsers,
        case .request = action else { return }

    let dataService = RemoteDataService()
    dataService.fetchUsers()
        .then { dispatch(FetchUsers.success(users: $0)) }
        .catch { dispatch(FetchUsers.failure(error: $0)) }
}

// AppDelegate.swift
let sideEffects = [
    fetchUsers,
    fetchPosts,
    createPost
]
let middleware = createMiddleware(items: sideEffects)
let store = Store<AppState>(reducer: appReducer, state: nil, middleware: [middleware])
```

In order to make it testable, we can wrap it in a function that provides the dependency:

```swift
// SideEffects/fetchUsers.swift
func fetchUsers(dataService: DataService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? FetchUsers,
            case .request = action else { return }

        dataService.fetchUsers()
            .then { dispatch(FetchUsers.success(users: $0)) }
            .catch { dispatch(FetchUsers.failure(error: $0)) }
    }
}

// AppDelegate.swift
let sideEffects = [
    fetchUsers(RemoteDataService()),
    fetchPosts(RemoteDataService()),
    createPost(RemoteDataService()),
]
let middleware = createMiddleware(items: sideEffects)
let store = Store<AppState>(reducer: appReducer, state: nil, middleware: [middleware])
```
