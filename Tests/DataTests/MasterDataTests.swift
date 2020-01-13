//
//  MasterDataTests.swift
//
//
//  Created by byunfi on 2020/1/5.
//

@testable import Data
import XCTest

final class MasterDataTests: XCTestCase {
    let masterData = MasterDataLibraryManager(databaseDirectoryURL: URL(string: "file:///Users/byunfi/Downloads")!, fileName: "md.sqlite")

    func testMDTreasureDeviceInfo() {
        let tds = try! masterData.servantTreasureDevices(servantId: 100_800)
        XCTAssert(tds.count == 2)
        let origin = tds[0]
        let strength = tds[1]
        XCTAssertNil(origin.mstQuest?.name)
        XCTAssert(origin.mstSvtTreasureDevice.strengthStatus == 1)
        XCTAssertNotNil(strength.mstQuest?.name)
        XCTAssert(strength.mstSvtTreasureDevice.strengthStatus == 2)
    }

    func testMDOwnedSkillInfo() {
        let skills = try! masterData.servantSkills(servantId: 100_800)
        XCTAssert(skills.count == 4)
        XCTAssertNil(skills[2].mstQuest?.name)
        XCTAssert(skills[2].mstSvtSkill.strengthStatus == 1)
        XCTAssertNotNil(skills[3].mstQuest?.name)
        XCTAssert(skills[3].mstSvtSkill.strengthStatus == 2)
    }

//
//    func testQuestName() {
//        XCTAssert(try! masterData.questName(id: 94012505)! == "强化关卡 齐格飞 2")
//        XCTAssert(try! masterData.questName(id: 1000001)! == "燃える街")
//    }
//
    func testServantDetailInfo() {
        let svt = try! masterData.servantDetail(servantId: 100_800)
        XCTAssert(svt.servant.mstSvt.name == "齐格飞")
        XCTAssert(svt.skills.count == 4)
        XCTAssert(svt.treasureDevices.count == 2)
        XCTAssert(svt.classPassives.count == 1)
    }
}
