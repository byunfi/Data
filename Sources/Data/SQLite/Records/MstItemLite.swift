//
//  MstItemLite.swift
//
//
//  Created by byunfi on 2020/1/13.
//

import Foundation
import GRDB

public struct MstItemLite {
    public let id: Int
    public let name: String?
    public let jpName: String
}

extension MstItemLite: DecodableTableRecord {
    public static var databaseTableName: String {
        "mstItem"
    }

    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.id, .name, .jpName]
        return codingKeys
    }
}

extension MstItemLite: FetchableRecord {}
