//
//  MDServantSkillInfo.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDServantSkillInfo: Decodable, FetchableRecord {
    public let mstSvtSkill: MstSvtSkill
    public let mstSkill: MstSkill
    public let mstQuest: MstQuestLite?
    public let mstSkillLv: MstSkillLv
    public let mstSkillDetail: MstSkillDetail
}
