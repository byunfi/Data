//
//  MstCombineLimit.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstCombineLimit {
    public let itemIds: [Int]
    public let itemNums: [Int]
    public let id: Int
    public let svtLimit: Int
    public let qp: Int
}

extension MstCombineLimit: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.itemIds, .itemNums, .id, .svtLimit, .qp]
        return codingKeys
    }
}

extension MstCombineLimit: FetchableRecord {}
