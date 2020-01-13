//
//  MstQuestLite.swift
//
//
//  Created by byunfi on 2020/1/13.
//

import Foundation
import GRDB

public struct MstQuestLite {
    public let id: Int
    public let name: String?
    public let jpName: String
}

extension MstQuestLite: DecodableTableRecord {
    public static var databaseTableName: String {
        "mstQuest"
    }

    static var codingKeys: [CodingKey] {
        let codingKeys: [CodingKeys] = [.id, .name, .jpName]
        return codingKeys
    }
}

extension MstQuestLite: FetchableRecord {}
