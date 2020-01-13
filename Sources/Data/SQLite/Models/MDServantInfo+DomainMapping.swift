//
//  MDServantInfo+DomainMapping.swift.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Domain
import Foundation

extension Servant {
    static func map(info: MDServantInfo, gameURLService: GameImageResourceURL) -> Servant {
        let svt = info.mstSvt
        let limit = info.mstSvtLimit
        return Servant(id: svt.id,
                       faceImageURL: gameURLService.servantFace(svt.id, stage: 0),
                       collectionNo: svt.collectionNo,
                       name: svt.name,
                       jpName: svt.jpName,
                       classId: svt.classId,
                       rarity: limit.rarity)
    }
}
