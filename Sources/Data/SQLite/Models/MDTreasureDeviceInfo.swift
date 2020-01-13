//
//  MDTreasureDeviceInfo.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDTreasureDeviceInfo: Decodable, FetchableRecord {
    public let mstQuest: MstQuestLite?
    public let mstSvtTreasureDevice: MstSvtTreasureDevice
    public let mstTreasureDevice: MstTreasureDevice
    public let mstTreasureDeviceDetail: MstTreasureDeviceDetail
}
