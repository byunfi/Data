//
//  MDTreasureDeviceInfo+DomainMapping.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain

extension ServantTreasureDevice {
    static func map(info: MDTreasureDeviceInfo) -> ServantTreasureDevice {
        let treasureDevice = info.treasureDeviceInfo
        let svtTreasureDevice = info.svtTreasureDeviceInfo
        let effects = ServantActionEffect.map(info: info.detailInfo)
        return ServantTreasureDevice(name: treasureDevice.name ?? treasureDevice.jpName,
                                     cardId: svtTreasureDevice.cardId,
                                     damage: svtTreasureDevice.damage,
                                     rank: treasureDevice.rank,
                                     typeText: treasureDevice.typeText,
                                     strengthStatus: svtTreasureDevice.strengthStatus,
                                     flag: svtTreasureDevice.flag,
                                     condFriendshipRank: svtTreasureDevice.condFriendshipRank,
                                     condQuestId: svtTreasureDevice.condQuestId,
                                     condQuestName: info.questInfo.name ?? info.questInfo.jpName,
                                     condQuestPhase: svtTreasureDevice.condQuestPhase,
                                     condLv: svtTreasureDevice.condLv,
                                     detail: effects)
    }
}
