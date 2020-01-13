//
//  MstSvt.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstSvt {
    public let relateQuestIds: String
    public let individuality: String
    public let classPassive: String
    public let cardIds: String
    public let script: String
    public let id: Int
    public let baseSvtId: Int
    public let jpName: String
    public let ruby: String
    public let battleName: String
    public let classId: Int
    public let type: Int
    public let limitMax: Int
    public let rewardLv: Int
    public let friendshipId: Int
    public let maxFriendshipRank: Int
    public let genderType: Int
    public let attri: Int
    public let combineSkillId: Int
    public let combineLimitId: Int
    public let sellQp: Int
    public let sellMana: Int
    public let sellRarePri: Int
    public let expType: Int
    public let combineMaterialId: Int
    public let cost: Int
    public let battleSize: Int
    public let starRate: Int
    public let deathRate: Int
    public let attackAttri: Int
    public let illustratorId: Int
    public let cvId: Int
    public let collectionNo: Int
    public let materialStoryPriority: Int
    public let flag: Int
    public let name: String?
}

extension MstSvt: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.relateQuestIds, .individuality, .classPassive, .cardIds, .script, .id, .baseSvtId, .jpName, .ruby, .battleName, .classId, .type, .limitMax, .rewardLv, .friendshipId, .maxFriendshipRank, .genderType, .attri, .combineSkillId, .combineLimitId, .sellQp, .sellMana, .sellRarePri, .expType, .combineMaterialId, .cost, .battleSize, .starRate, .deathRate, .attackAttri, .illustratorId, .cvId, .collectionNo, .materialStoryPriority, .flag, .name]
        return codingKeys
    }
}

extension MstSvt: FetchableRecord {
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let collectionNo = Column(CodingKeys.collectionNo)
        static let type = Column(CodingKeys.type)
        static let classPassive = Column(CodingKeys.classPassive)
    }
}

// MARK: - Foreign Keys

extension MstSvt {
    public static let svtLimit = hasOne(MstSvtLimit.self)
}
