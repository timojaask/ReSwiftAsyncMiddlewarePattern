func injectService<T, U>(service: T, receivers: [(T) -> (U)]) -> [U] {
    return receivers.map { $0(service) }
}
