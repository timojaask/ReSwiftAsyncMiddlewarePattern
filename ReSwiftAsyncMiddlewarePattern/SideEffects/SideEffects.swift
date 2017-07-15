import ReSwift

typealias SideEffect = (Action, @escaping DispatchFunction) -> ()

func instantiateSideEffects(dataService: DataService) -> [SideEffect] {
    return [
        fetchUsers(dataService: dataService),
        fetchPosts(dataService: dataService),
        createPost(dataService: dataService),
    ]
}

func sideEffectsMiddleware(sideEffects: [SideEffect]) -> Middleware<Any> {
    return { dispatch, getState in
        return { next in
            return { action in
                sideEffects.forEach { $0(action, dispatch) }
                return next(action)
            }
        }
    }
}
