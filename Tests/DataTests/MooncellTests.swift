import XCTest
@testable import Data
import Moya
import Domain
import RxTest
import RxBlocking
import GRDB

final class MooncellTests: XCTestCase {
    
    func testHomeData() {
        let repo = DefaultMooncellRepository(network: MooncellNetwork())
        let _ = try! repo.fetchHomeData(targetSource: .CN).toBlocking(timeout: 100).first()!
        let _ = try! repo.fetchHomeData(targetSource: .JP).toBlocking(timeout: 100).first()!
        repo.refreshHome()
        let _ = try! repo.fetchHomeData(targetSource: .CN).toBlocking(timeout: 100).first()!
    }

    static var allTests = [
        ("testHomeData", testHomeData),
    ]
}
