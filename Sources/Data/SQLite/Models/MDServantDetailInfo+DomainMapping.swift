//
//  File.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Domain
import Foundation

extension ServantDetail {
    static func map(info: MDServantDetailInfo, gameURLService: GameImageResourceURL) -> ServantDetail {
        let svtInfo = info.servant.mstSvt
        return ServantDetail(id: svtInfo.id,
                             faceImageURL: gameURLService.servantFace(svtInfo.id, stage: 0),
                             collectionNo: svtInfo.collectionNo,
                             name: svtInfo.name,
                             jpName: svtInfo.jpName,
                             classId: svtInfo.classId,
                             rarity: info.servant.mstSvtLimit.rarity,
                             treasureDevices: info.treasureDevices.map(ServantTreasureDevice.map(info:)),
                             skills: info.skills.map { ServantSkill.map(info: $0, gameURLService: gameURLService) },
                             classPassives: info.classPassives.map { ServantClassPassive.map(info: $0, gameURLService: gameURLService) })
    }
}
