//
//  MasterDataTests.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import XCTest
@testable import Data
import Domain
import RxTest
import RxBlocking
import GRDB

final class MasterDataTests: XCTestCase {
    
    let masterData = MasterData(databaseDirectoryURL: URL(string: "file:///Users/byunfi/Downloads")!, fileName: "md.sqlite")
    
    func testMDTreasureDeviceInfo() {
        let tds = try! masterData.treasureDevices(svtId: 100800)
        XCTAssert(tds.count == 2)
        let origin = tds[0]
        let strength = tds[1]
        XCTAssertNil(origin.questInfo.name)
        XCTAssert(origin.svtTreasureDeviceInfo.strengthStatus == 1)
        XCTAssertNotNil(strength.questInfo.name)
        XCTAssert(strength.svtTreasureDeviceInfo.strengthStatus == 2)
    }
    
    func testMDOwnedSkillInfo() {
        let skills = try! masterData.ownedSkills(svtId: 100800)
        XCTAssert(skills.count == 4)
        XCTAssertNil(skills[2].questInfo.name)
        XCTAssert(skills[2].svtSkillInfo.strengthStatus == 1)
        XCTAssertNotNil(skills[3].questInfo.name)
        XCTAssert(skills[3].svtSkillInfo.strengthStatus == 2)
    }
    
    func testQuestName() {
        XCTAssert(try! masterData.questName(id: 94012505)! == "强化关卡 齐格飞 2")
        XCTAssert(try! masterData.questName(id: 1000001)! == "燃える街")
    }
    
    func testServantInfo() {
        let svt = try! masterData.servant(svtId: 100800)
        XCTAssert(svt.servant.svtInfo.name == "齐格飞")
        XCTAssert(svt.ownedSkills.count == 4)
        XCTAssert(svt.treasureDevices.count == 2)
        XCTAssert(svt.classSkills.count == 1)
    }
}
    
