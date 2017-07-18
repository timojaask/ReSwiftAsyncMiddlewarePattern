import ReSwift

func createMiddleware(items: [MiddlewareItem]) -> Middleware<AppState> {
    return { dispatch, getState in
        return { next in
            return { action in
                items.forEach { $0(action, dispatch) }
                return next(action)
            }
        }
    }
}
