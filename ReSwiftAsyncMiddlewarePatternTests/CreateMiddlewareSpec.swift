import Quick
import Nimble
import ReSwift
@testable import ReSwiftAsyncMiddlewarePattern

class CreateMiddlewareSpec: QuickSpec {

    override func spec() {
        describe("createMiddleware") {
            it("calls all middleware items when action is dispatched") {
                var middlewareItem1Called = false
                var middlewareItem2Called = false

                let middlewareItems = [
                    { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                        middlewareItem1Called = true
                    },
                    { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                        middlewareItem2Called = true
                    }
                ]

                self.callMiddleware(action: FetchPosts.request, items: middlewareItems)

                expect(middlewareItem1Called).toEventually(beTrue(), timeout: 1)
                expect(middlewareItem2Called).toEventually(beTrue(), timeout: 1)
            }

            it("passes correct action to all middleware items") {
                let expectedPosts = randomPosts()
                var actualPosts1: [Post]?
                var actualPosts2: [Post]?

                let middlewareItems = [
                    { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                        guard let action = action as? FetchPosts,
                            case .success(let fetchedPosts) = action else { return }
                        actualPosts1 = fetchedPosts
                    },
                    { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                        guard let action = action as? FetchPosts,
                            case .success(let fetchedPosts) = action else { return }
                        actualPosts2 = fetchedPosts
                    }
                ]

                let action = FetchPosts.success(posts: expectedPosts)
                self.callMiddleware(action: action, items: middlewareItems)

                expect(actualPosts1).toEventually(equal(expectedPosts), timeout: 1)
                expect(actualPosts2).toEventually(equal(expectedPosts), timeout: 1)
            }

            it("passes correct dispatch function to all middleware items") {
                let expectedPosts = randomPosts()
                let expectedDispatchCalls = 2
                var actualDispatchCalls = 0

                let middlewareItems = [
                    { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                        dispatch(FetchPosts.success(posts: expectedPosts))
                    },
                    { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                        dispatch(FetchPosts.success(posts: expectedPosts))
                    }
                ]

                self.callMiddleware(action: FetchPosts.request, items: middlewareItems) { action in
                    guard let action = action as? FetchPosts,
                        case .success(let actualPosts) = action else { return }

                    actualDispatchCalls += 1
                    expect(actualPosts).to(equal(expectedPosts))
                }

                expect(actualDispatchCalls).toEventually(equal(expectedDispatchCalls))
            }
        }
    }

    func callMiddleware(action: Action, items: [MiddlewareItem], dispatchFunction: ((Action) -> Void)? = nil) {
        let middleware = createMiddleware(items: items)
        let dispatchFunction = dispatchFunction ?? { (_: Action) in }
        let getState = { () -> AppState? in AppState() }
        middleware(dispatchFunction, getState)(dispatchFunction)(action)
    }
}
