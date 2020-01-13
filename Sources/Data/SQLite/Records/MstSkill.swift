//
//  MstSkill.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstSkill {
    public let id: Int
    public let type: Int
    public let jpName: String
    public let maxLv: Int
    public let iconId: Int
    public let name: String?
}

extension MstSkill {
    public static let skillDetail = hasOne(MstSkillDetail.self)
    public static let skillLv = hasOne(MstSkillLv.self)
}

extension MstSkill: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.id, .type, .jpName, .maxLv, .iconId, .name]
        return codingKeys
    }
}

extension MstSkill: FetchableRecord {}
