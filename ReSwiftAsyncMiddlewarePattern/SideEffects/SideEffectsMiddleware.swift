import ReSwift

typealias SideEffect = (Action, @escaping DispatchFunction) -> ()
typealias DataServiceSideEffects = (DataService) -> SideEffect

func sideEffectsMiddleware(dataService: DataService, dataServiceSideEffects: [DataServiceSideEffects]) -> Middleware<Any> {
    return { dispatch, getState in
        return { next in
            return { action in
                dataServiceSideEffects.forEach { $0(dataService)(action, dispatch) }
                return next(action)
            }
        }
    }
}
