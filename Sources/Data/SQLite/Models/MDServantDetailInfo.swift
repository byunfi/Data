//
//  MDServantDetailInfo.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDServantDetailInfo: FetchableRecord, Decodable {
    public let servant: MDServantInfo
    public let treasureDevices: [MDTreasureDeviceInfo]
    public let skills: [MDServantSkillInfo]
    public let classPassives: [MDServantClassPassiveInfo]
}
