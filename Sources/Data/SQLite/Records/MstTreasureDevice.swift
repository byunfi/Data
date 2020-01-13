//
//  MstTreasureDevice.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstTreasureDevice {
    public let id: Int
    public let jpName: String
    public let ruby: String
    public let rank: String
    public let maxLv: Int
    public let typeText: String
    public let name: String
}

extension MstTreasureDevice {
    public static let treasureDeviceDetail = hasOne(MstTreasureDeviceDetail.self)
    public static let treasureDeviceLv = hasOne(MstTreasureDeviceLv.self)
}

extension MstTreasureDevice: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.id, .jpName, .name, .typeText, .maxLv, .ruby, .rank]
        return codingKeys
    }
}

extension MstTreasureDevice: FetchableRecord {}
