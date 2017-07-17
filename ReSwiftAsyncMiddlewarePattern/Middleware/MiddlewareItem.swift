import ReSwift

typealias MiddlewareItem = (Action, @escaping DispatchFunction) -> ()
