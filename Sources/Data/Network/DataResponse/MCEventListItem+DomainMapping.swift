//
//  File.swift
//
//
//  Created by byunfi on 2020/1/8.
//

import Domain
import Foundation

extension GameEventDetail {
    static func map(item: MCEventListItem) -> GameEventDetail {
        GameEventDetail(name: item.name,
                        activityNoticeURL: item.officialHref,
                        bannerImageURL: item.imageSrc,
                        wikiRefrenceURL: item.href,
                        openDate: item.openDate,
                        closeDate: item.closeDate,
                        type: item.type)
    }
}
