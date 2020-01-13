//
//  MDServantClassPassiveInfo+DomainMapping.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Domain
import Foundation

extension ServantClassPassive {
    static func map(info: MDServantClassPassiveInfo, gameURLService: GameImageResourceURL) -> ServantClassPassive {
        let skill = info.mstSkill
        let detail = info.mstSkillDetail
        let effects = zip(detail.detail, detail.value).map(ServantActionEffect.init)
        return ServantClassPassive(name: skill.name ?? skill.jpName, iconImageURL: gameURLService.skill(skill.iconId), detail: effects)
    }
}
