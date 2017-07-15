import ReSwift

typealias SideEffect = (Action, @escaping DispatchFunction) -> ()

let dataServiceSideEffects = [
    fetchUsers,
    fetchPosts,
    createPost
]

func sideEffectsMiddleware(dataService: DataService) -> Middleware<Any> {
    return { dispatch, getState in
        return { next in
            return { action in
                dataServiceSideEffects.forEach { $0(dataService)(action, dispatch) }
                return next(action)
            }
        }
    }
}
