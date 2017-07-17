import UIKit
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var store: Store<AppState>!
    let debugStoreSubscriber = DebugStoreSubscriber()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let sideEffects = injectService(service: RemoteDataService(), receivers: dataServiceSideEffects)
        let middleware = createMiddleware(items: sideEffects)
        store = Store<AppState>(reducer: appReducer, state: nil, middleware: [middleware])
        store.subscribe(debugStoreSubscriber)

        testPostingAndFetchingStuff()
        return true
    }

    func testPostingAndFetchingStuff() {
//        store.dispatch(FetchUsersRequest())
        let testPost = Post(title: "New Post", body: "Body of the new post")
//        store.dispatch(FetchPosts.request)
        store.dispatch(CreatePost.request(post: testPost))
        store.dispatch(FetchPosts.request)
    }
}

class DebugStoreSubscriber: StoreSubscriber {
    func newState(state: AppState) {
        print("State changed")
        print(" -- posts: \(state.posts)")
        print(" -- users: \(state.users)")
    }
}
