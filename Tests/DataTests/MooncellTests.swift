@testable import Data
import Domain
import GRDB
import Moya
import RxBlocking
import RxTest
import XCTest

final class MooncellTests: XCTestCase {
    func testHomeData() {
        let repo = DefaultMooncellRepository(network: MooncellNetwork())
        _ = try! repo.fetchHomeData(targetSource: .CN).toBlocking(timeout: 100).first()!
        _ = try! repo.fetchHomeData(targetSource: .JP).toBlocking(timeout: 100).first()!
        repo.refreshHome()
        _ = try! repo.fetchHomeData(targetSource: .CN).toBlocking(timeout: 100).first()!
    }

    static var allTests = [
        ("testHomeData", testHomeData),
    ]
}
