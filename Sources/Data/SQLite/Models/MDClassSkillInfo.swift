//
//  MDClassSkillInfo.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDClassSkillInfo: FetchableRecord, Decodable {
    
    public struct MDSkillInfo: Decodable {
        public let id: Int
        public let name: String?
        public let jpName: String
        public let iconId: Int
    }
    
    public struct MDClassSkillDetailInfo: Decodable {
        public let detail: [String]
        public let value: [String]
    }

    public let skillInfo: MDSkillInfo
    public let detailInfo: MDClassSkillDetailInfo
}
