//
//  MDServantClassPassiveInfo.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDServantClassPassiveInfo: Decodable, FetchableRecord {
    public let mstSkill: MstSkill
    public let mstSkillDetail: MstSkillDetail
}
