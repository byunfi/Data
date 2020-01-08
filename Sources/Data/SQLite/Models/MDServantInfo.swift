//
//  MDServantLiteInfo.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDServantInfo: FetchableRecord, Decodable {
    
    public struct MDSvtLimitInfo: Decodable {
        public let rarity: Int
    }
    
    public struct MDSvtInfo: Decodable {
        public let id: Int
        public let collectionNo: Int
        public let name: String?
        public let jpName: String
        public let classId: Int
    }

    public let svtLimitInfo: MDSvtLimitInfo
    public let svtInfo: MDSvtInfo
}
