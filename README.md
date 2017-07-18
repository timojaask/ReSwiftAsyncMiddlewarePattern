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

This makes it difficult to test action creators, as it is not clear how to replace `Octokit` object with a test stub.

## Solution
Instead of firing asynchronous operations from within action creators, we can use a ReSwift middleware, whose only job will be doing any side effects:

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
]
let middleware = createMiddleware(items: sideEffects)
let store = Store<AppState>(reducer: appReducer, state: nil, middleware: [middleware])
```
