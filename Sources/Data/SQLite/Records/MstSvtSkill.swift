//
//  MstSvtSkill.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstSvtSkill {
    public let strengthStatus: Int
    public let svtId: Int
    public let num: Int
    public let skillId: Int
    public let condQuestId: Int
    public let condQuestPhase: Int
    public let condLv: Int
    public let condLimitCount: Int
    public let eventId: Int
    public let flag: Int
}

extension MstSvtSkill {
    public static let skill = hasOne(MstSkill.self)
    public static let quest = hasOne(MstQuest.self, using: ForeignKey(["id"], to: ["condQuestId"]))
}

extension MstSvtSkill: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.strengthStatus, .svtId, .num, .skillId, .condQuestId, .condQuestPhase, .condLv, .condLimitCount, .eventId, .flag]
        return codingKeys
    }
}

extension MstSvtSkill: FetchableRecord {
    enum Columns {
        static let svtId = Column(CodingKeys.svtId)
        static let num = Column(CodingKeys.num)
        static let strengthStatus = Column(CodingKeys.strengthStatus)
        static let flag = Column(CodingKeys.flag)
    }
}
