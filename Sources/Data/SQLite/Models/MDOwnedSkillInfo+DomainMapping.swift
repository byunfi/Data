//
//  MDOwnedSkillInfo+DomainMapping.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain

extension ServantSkill {
    static func map(info: MDOwnedSkillInfo, gameURLService: GameImageResourceURL) -> ServantSkill {
        let skill = info.skillInfo
        let svtSkill = info.svtSkillInfo
        let effects = ServantActionEffect.map(info: info.detailInfo)
        return ServantSkill(num: svtSkill.num,
                            name: skill.name ?? skill.jpName,
                            chargeTurn: info.skillLvInfo.chargeTurn,
                            iconImageURL: gameURLService.skill(skill.iconId),
                            strengthStatus: svtSkill.strengthStatus,
                            flag: svtSkill.flag,
                            condQuestId: svtSkill.condQuestId,
                            condQuestName: info.questInfo.name ?? info.questInfo.jpName,
                            condQuestPhase: svtSkill.condQuestPhase,
                            condLv: svtSkill.condLv,
                            condLimitCount: svtSkill.condLimitCount,
                            detail: effects)
    }
}
