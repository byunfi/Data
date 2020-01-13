//
//  MstTreasureDeviceLv.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstTreasureDeviceLv {
    public let treaureDeviceId: Int
    public let lv: Int
    public let tdPoint: Int
    public let tdPointQ: Int
    public let tdPointA: Int
    public let tdPointB: Int
    public let tdPointEx: Int
    public let tdPointDef: Int
}

extension MstTreasureDeviceLv: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.treaureDeviceId, .lv, .tdPoint, .tdPointQ, .tdPointA, .tdPointB, .tdPointEx, .tdPointDef]
        return codingKeys
    }
}

extension MstTreasureDeviceLv: FetchableRecord {}
