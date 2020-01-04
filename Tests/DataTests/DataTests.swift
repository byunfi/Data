import XCTest
@testable import Data
import Moya
import Domain
import RxTest
import RxBlocking

final class DataTests: XCTestCase {
    
    func testMonncellHomeNetwok() {
        let net = MonncellNetwok(provider: MoyaProvider<MooncellService>())
        let homeData = try! net.fetchHomeData().toBlocking(timeout: 5).first()!
        XCTAssert(homeData.count == 2)
        let eventLists = try! net.fetchEventList().toBlocking(timeout: 5).first()!
        XCTAssert(eventLists.count > 1)
    }

    static var allTests = [
        ("testMonncellHomeNetwok", testMonncellHomeNetwok),
    ]
}
