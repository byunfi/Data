//
//  MDClassSkillInfo+DomainMapping.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain

extension ServantClassPassive {
    static func map(info: MDClassSkillInfo, gameURLService: GameImageResourceURL) -> ServantClassPassive {
        let skill = info.skillInfo
        let detail = info.detailInfo
        let effects = zip(detail.detail, detail.value).map { ServantActionEffect(description: $0.0, levelValues: [$0.1]) }
        return ServantClassPassive(name: skill.name ?? skill.jpName, iconImageURL: gameURLService.skill(skill.iconId), detail: effects)
    }
}
