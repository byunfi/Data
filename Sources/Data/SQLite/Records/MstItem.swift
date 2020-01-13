//
//  MstItem.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstItem {
    public let eventId: Int
    public let eventGroupId: Int
    public let id: Int
    public let jpName: String
    public let detail: String
    public let imageId: Int
    public let type: Int
    public let dropPriority: Int
    public let name: String
}

extension MstItem: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.eventId, .eventGroupId, .id, .jpName, .detail, .imageId, .type, .dropPriority, .name]
        return codingKeys
    }
}

extension MstItem: FetchableRecord {}
