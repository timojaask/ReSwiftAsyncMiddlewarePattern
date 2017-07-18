import Foundation
@testable import ReSwiftAsyncMiddlewarePattern

extension String {
    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = UInt32(letters.characters.count)

        return (0 ..< length).reduce(String()) { accum, _ in
            let randomOffset = arc4random_uniform(length)
            let randomIndex = letters.index(letters.startIndex, offsetBy: Int(randomOffset))
            return accum.appending(String(letters[randomIndex]))
        }
    } 
}
