//
//  MstSvtLite.swift
//
//
//  Created by byunfi on 2020/1/13.
//

import Foundation
import GRDB

public struct MstSvtLite {
    public let cardIds: String
    public let script: String
    public let id: Int
    public let jpName: String
    public let classId: Int
    public let collectionNo: Int
    public let name: String?
}

extension MstSvtLite: DecodableTableRecord {
    public static var databaseTableName: String {
        "mstSvt"
    }

    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.cardIds, .script, .id, .jpName, .classId, .collectionNo, .name]
        return codingKeys
    }
}

extension MstSvtLite: FetchableRecord {}
