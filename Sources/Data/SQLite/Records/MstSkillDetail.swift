//
//  MstSkillDetail.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstSkillDetail {
    public let id: Int
    public let detail: [String]
    public let value: [[String]]
}

extension MstSkillDetail: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.id, .detail, .value]
        return codingKeys
    }
}

extension MstSkillDetail: FetchableRecord {}
