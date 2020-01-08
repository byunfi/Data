//
//  MDTreasureDeviceInfo.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDTreasureDeviceInfo: FetchableRecord, Decodable {
    public struct MDTreasureDeviceInfo: Decodable {
        public let id: Int
        public let name: String?
        public let jpName: String
        public let maxLv: Int
        public let rank: String
        public let typeText: String
    }
    
    public struct MDQuestInfo: Decodable {
        public let name: String?
        public let jpName: String?
    }
    
    public struct MDSvtTreasureDeviceInfo: Decodable {
        public let treasureDeviceId: Int
        public let cardId: Int
        public let damage: [Int]
        public let strengthStatus: Int
        public let flag: Int
        public let condFriendshipRank: Int
        public let condQuestId: Int
        public let condQuestPhase: Int
        public let condLv: Int
    }

    public let questInfo: MDQuestInfo
    public let svtTreasureDeviceInfo: MDSvtTreasureDeviceInfo
    public let treasureDeviceInfo: MDTreasureDeviceInfo
    public let detailInfo: MDDetailInfo
}
