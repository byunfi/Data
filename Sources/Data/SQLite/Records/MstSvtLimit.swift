//
//  MstSvtLimit.swift
//
//
//  Created by byunfi on 2019/12/13.
//

import Foundation
import GRDB

public struct MstSvtLimit {
    public let svtId: Int
    public let limitCount: Int
    public let rarity: Int
    public let lvMax: Int
    public let hpBase: Int
    public let hpMax: Int
    public let atkBase: Int
    public let atkMax: Int
    public let criticalWeight: Int
    public let power: Int
    public let defense: Int
    public let agility: Int
    public let magic: Int
    public let luck: Int
    public let treasureDevice: Int
    public let policy: Int
    public let personality: Int
    public let deity: Int
}

extension MstSvtLimit: DecodableTableRecord {
    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.svtId, .limitCount, .rarity, .lvMax, .hpBase, .hpMax, .atkBase, .atkMax, .criticalWeight, .power, .defense, .agility, .magic, .luck, .treasureDevice, .policy, .personality, .deity]
        return codingKeys
    }
}

extension MstSvtLimit: FetchableRecord {
    enum Columns {
        static let limitCount = Column(CodingKeys.limitCount)
    }
}
