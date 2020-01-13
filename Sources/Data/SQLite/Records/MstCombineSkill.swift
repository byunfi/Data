//
//  MstCombineSkill.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstCombineSkill {
    public let itemIds: [Int]
    public let itemNums: [Int]
    public let id: Int
    public let skillLv: Int
    public let qp: Int
}

extension MstCombineSkill: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.itemIds, .itemNums, .id, .skillLv, .qp]
        return codingKeys
    }
}

extension MstCombineSkill: FetchableRecord {}
