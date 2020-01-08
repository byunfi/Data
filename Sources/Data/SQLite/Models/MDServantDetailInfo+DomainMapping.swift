//
//  File.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain

extension ServantDetail {
    static func map(info: MDServantDetailInfo, gameURLService: GameImageResourceURL) -> ServantDetail {
        let svtInfo = info.servant.svtInfo
        return ServantDetail(id: svtInfo.id,
                             faceImageURL: gameURLService.servantFace(svtInfo.id, stage: 0),
                             collectionNo: svtInfo.collectionNo,
                             name: svtInfo.name,
                             jpName: svtInfo.jpName,
                             classId: svtInfo.classId,
                             rarity: info.servant.svtLimitInfo.rarity,
                             treasureDevices: info.treasureDevices.map(ServantTreasureDevice.map(info:)),
                             skills: info.ownedSkills.map { ServantSkill.map(info: $0, gameURLService: gameURLService) },
                             classPassives: info.classSkills.map {ServantClassPassive.map(info: $0, gameURLService: gameURLService)})
    }

}
