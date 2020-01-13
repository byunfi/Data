//
//  MstSvtTreasureDevice.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstSvtTreasureDevice {
    public let damage: [Int]
    public let strengthStatus: Int
    public let svtId: Int
    public let num: Int
    public let priority: Int
    public let flag: Int
    public let treasureDeviceId: Int
    public let condQuestId: Int
    public let condQuestPhase: Int
    public let condLv: Int
    public let condFriendshipRank: Int
    public let cardId: Int
}

extension MstSvtTreasureDevice {
    public static let treasureDevice = hasOne(MstTreasureDevice.self)
    public static let quest = hasOne(MstQuest.self, using: ForeignKey(["id"], to: ["condQuestId"]))
}

extension MstSvtTreasureDevice: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.damage, .strengthStatus, .svtId, .num, .priority, .flag, .treasureDeviceId, .condQuestId, .condQuestPhase, .condLv, .condFriendshipRank, .cardId]
        return codingKeys
    }
}

extension MstSvtTreasureDevice: FetchableRecord {
    enum Columns {
        static let svtId = Column(CodingKeys.svtId)
        static let strengthStatus = Column(CodingKeys.strengthStatus)
        static let flag = Column(CodingKeys.flag)
        static let num = Column(CodingKeys.num)
    }
}
