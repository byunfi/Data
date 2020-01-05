//
//  File.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

struct MDServantLiteInfo: FetchableRecord, Decodable {
    
    struct MstSvtLimitInfo: Decodable {
        let rarity: Int
    }
    
    struct MstSvtInfo: Decodable {
        let id: Int
        let collectionNo: Int
        let name: String?
        let jpName: String
        let classId: Int
    }

    let mstSvtLimitInfo: MstSvtLimitInfo
    let mstSvtInfo: MstSvtInfo
}

//extension MDServantLite.MstSvtInfo: TableRecord {
//    static var databaseTableName: String { "MstSvt" }
//    static var databaseSelection: [SQLSelectable] = [Column("id"), Column("collectionNo"), Column("name"), Column("jpName"), Column("classId")]
//}
