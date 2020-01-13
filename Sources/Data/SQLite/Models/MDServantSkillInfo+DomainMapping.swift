//
//  MDServantSkillInfo+DomainMapping.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Domain
import Foundation

extension ServantSkill {
    static func map(info: MDServantSkillInfo, gameURLService: GameImageResourceURL) -> ServantSkill {
        let skill = info.mstSkill
        let svtSkill = info.mstSvtSkill
        let effects = zip(info.mstSkillDetail.detail, info.mstSkillDetail.value).map(ServantActionEffect.init)
        return ServantSkill(num: svtSkill.num,
                            name: skill.name ?? skill.jpName,
                            chargeTurn: info.mstSkillLv.chargeTurn,
                            iconImageURL: gameURLService.skill(skill.iconId),
                            strengthStatus: svtSkill.strengthStatus,
                            flag: svtSkill.flag,
                            condQuestId: svtSkill.condQuestId,
                            condQuestName: info.mstQuest?.name ?? info.mstQuest?.jpName,
                            condQuestPhase: svtSkill.condQuestPhase,
                            condLv: svtSkill.condLv,
                            condLimitCount: svtSkill.condLimitCount,
                            detail: effects)
    }
}
