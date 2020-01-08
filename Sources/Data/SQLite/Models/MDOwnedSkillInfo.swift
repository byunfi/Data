//
//  MDOwnedSkillInfo.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDOwnedSkillInfo: FetchableRecord, Decodable {
    public struct MDSvtSkill: Decodable {
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
    
    public struct MDSkillInfo: Decodable {
        public let id: Int
        public let name: String?
        public let jpName: String
        public let iconId: Int
        public let maxLv: Int
    }
    
    public struct MDQuestInfo: Decodable {
        public let name: String?
        public let jpName: String?
    }
    
    public struct MstSkillLvInfo: Decodable {
        public let chargeTurn: Int
    }
    
    public let svtSkillInfo: MDSvtSkill
    public let questInfo: MDQuestInfo
    public let skillInfo: MDSkillInfo
    public let detailInfo: MDDetailInfo
    public let skillLvInfo: MstSkillLvInfo
}
