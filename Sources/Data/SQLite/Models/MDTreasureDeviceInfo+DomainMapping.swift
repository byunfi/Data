//
//  MDTreasureDeviceInfo+DomainMapping.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Domain
import Foundation

extension ServantTreasureDevice {
    static func map(info: MDTreasureDeviceInfo) -> ServantTreasureDevice {
        let treasureDevice = info.mstTreasureDevice
        let svtTreasureDevice = info.mstSvtTreasureDevice
        let effects = zip(info.mstTreasureDeviceDetail.detail, info.mstTreasureDeviceDetail.value).map(ServantActionEffect.init)
        return ServantTreasureDevice(name: treasureDevice.name ?? treasureDevice.jpName,
                                     cardId: svtTreasureDevice.cardId,
                                     damage: svtTreasureDevice.damage,
                                     rank: treasureDevice.rank,
                                     typeText: treasureDevice.typeText,
                                     strengthStatus: svtTreasureDevice.strengthStatus,
                                     flag: svtTreasureDevice.flag,
                                     condFriendshipRank: svtTreasureDevice.condFriendshipRank,
                                     condQuestId: svtTreasureDevice.condQuestId,
                                     condQuestName: info.mstQuest?.name ?? info.mstQuest?.jpName,
                                     condQuestPhase: svtTreasureDevice.condQuestPhase,
                                     condLv: svtTreasureDevice.condLv,
                                     detail: effects)
    }
}
