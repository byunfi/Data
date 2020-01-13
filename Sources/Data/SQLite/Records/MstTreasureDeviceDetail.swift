//
//  MstTreasureDeviceDetail.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstTreasureDeviceDetail {
    public let id: Int
    public let detail: [String]
    public let value: [[String]]
}

extension MstTreasureDeviceDetail: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.id, .detail, .value]
        return codingKeys
    }
}

extension MstTreasureDeviceDetail: FetchableRecord {}
