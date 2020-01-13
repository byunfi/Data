//
//  MstQuest.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstQuest {
    public let id: Int
    public let jpName: String
    public let type: Int
    public let consumeType: Int
    public let actConsume: Int
    public let spotId: Int
    public let giftId: Int
    public let priority: Int
    public let bannerType: Int
    public let bannerId: Int
    public let iconId: Int
    public let charaIconId: Int
    public let giftIconId: Int
    public let afterClear: Int
    public let chapterId: Int
    public let chapterSubId: Int
    public let chapterSubStr: String
    public let recommendLv: String
    public let flag: Int
    public let openedAt: Int
    public let closedAt: Int
    public let name: String
}

extension MstQuest: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.id, .jpName, .type, .consumeType, .actConsume, .spotId, .giftId, .priority, .bannerType, .bannerId, .iconId, .charaIconId, .giftIconId, .afterClear, .chapterId, .chapterSubId, .chapterSubStr, .recommendLv, .flag, .openedAt, .closedAt, .name]
        return codingKeys
    }
}

extension MstQuest: FetchableRecord {}
