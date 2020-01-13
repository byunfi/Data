//
//  MstSkillLv.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstSkillLv {
    public let skillId: Int
    public let lv: Int
    public let chargeTurn: Int
}

extension MstSkillLv: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.skillId, .lv, .chargeTurn]
        return codingKeys
    }
}

extension MstSkillLv: FetchableRecord {
    enum Columns {
        static let lv = Column(CodingKeys.lv)
    }
}
