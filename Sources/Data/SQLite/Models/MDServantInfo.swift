//
//  MDServantLiteInfo.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDServantInfo: Decodable, FetchableRecord {
    public let mstSvt: MstSvtLite
    public let mstSvtLimit: MstSvtLimitLite
}
