//
//  MDDetailInfo.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

public struct MDDetailInfo: FetchableRecord, Decodable {
    public let detail: [String]
    public let value: [[String]]
}
