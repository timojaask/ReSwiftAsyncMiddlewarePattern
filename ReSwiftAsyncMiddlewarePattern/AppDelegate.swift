import UIKit
import ReSwift
import PromiseKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var store: Store<AppState>!
    let debugStoreSubscriber = DebugStoreSubscriber()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let sideEffects = instantiateSideEffects(dataService: RemoteDataService())
        let middleware = sideEffectsMiddleware(sideEffects: sideEffects)
        store = Store<AppState>(reducer: appReducer, state: nil, middleware: [middleware])
        store.subscribe(debugStoreSubscriber)
        store.dispatch(SetCreatePost(state: .request(post: Post(title: "New Post", body: "Body of the new post"))))
        store.dispatch(SetFetchPosts(state: .request))

        return true
    }
}

class DebugStoreSubscriber: StoreSubscriber {
    func newState(state: AppState) {
        print("State changed")
        print(" -- posts: \(state.posts)")
        print(" -- users: \(state.users)")
        print(" -- fetchUsers: \(state.asyncRequests.fetchUsers)")
        print(" -- fetchPosts: \(state.asyncRequests.fetchPosts)")
        print(" -- createPost: \(state.asyncRequests.createPost)")
    }
}
