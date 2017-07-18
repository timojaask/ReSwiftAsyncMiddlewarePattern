import Quick
import Nimble
import ReSwift
@testable import ReSwiftAsyncMiddlewarePattern

class InjectServiceSpec: QuickSpec {

    override func spec() {
        describe("injectService") {
            it("injects service into receivers") {

                let receivers = [
                    { (service: Int) -> (Int) in return service * 2 },
                    { (service: Int) -> (Int) in return service * 2 }
                ]
                let service: Int = randomNumber()

                let expected = [ service * 2, service * 2]
                let actual = injectService(service: service, receivers: receivers)

                expect(actual).to(equal(expected))
            }
        }
    }
}
