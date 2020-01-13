//
//  MstSvtLimitLite.swift
//
//
//  Created by byunfi on 2020/1/13.
//

import Foundation
import GRDB

public struct MstSvtLimitLite {
    public let rarity: Int
}

extension MstSvtLimitLite: DecodableTableRecord {
    public static var databaseTableName: String {
        "mstSvtLimit"
    }

    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.rarity]
        return codingKeys
    }
}

extension MstSvtLimitLite: FetchableRecord {}
