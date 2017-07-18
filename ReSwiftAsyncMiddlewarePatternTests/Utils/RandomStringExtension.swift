import Foundation
@testable import ReSwiftAsyncMiddlewarePattern

func randomNumber() -> Int { return randomNumber(min: 0, max: 100000000) }

func randomNumber(max: Int) -> Int { return randomNumber(min: 0, max: max) }

func randomNumber(min: Int, max: Int) -> Int {
    let upperBound = UInt32(max - min);
    return min + Int(arc4random_uniform(upperBound))
}

extension String {
    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        return (0 ..< length).reduce(String()) { accum, _ in
            let randomOffset = randomNumber(max: letters.characters.count)
            let randomIndex = letters.index(letters.startIndex, offsetBy: Int(randomOffset))
            return accum.appending(String(letters[randomIndex]))
        }
    } 
}
