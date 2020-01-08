//
//  MDServantInfo+DomainMapping.swift.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain

extension Servant {
    static func map(info: MDServantInfo, gameURLService: GameImageResourceURL) -> Servant {
        let svt = info.svtInfo
        let limit = info.svtLimitInfo
        return Servant(id: svt.id,
                       faceImageURL: gameURLService.servantFace(svt.id, stage: 0),
                       collectionNo: svt.collectionNo,
                       name: svt.name,
                       jpName: svt.jpName,
                       classId: svt.classId,
                       rarity: limit.rarity)
    }
}
