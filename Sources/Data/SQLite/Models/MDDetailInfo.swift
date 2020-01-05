//
//  File.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import GRDB

struct MDDetailInfo: FetchableRecord, Decodable {
    let detail: [String]
    let value: [[String]]
}
