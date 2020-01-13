//
//  TableRecord+databaseTableName.swift
//
//
//  Created by byunfi on 2020/1/12.
//

import Foundation
import GRDB

protocol DecodableTableRecord: Decodable, TableRecord {
    static var codingKeys: [CodingKey] { get }
}

extension DecodableTableRecord {
    public static var databaseTableName: String {
        let name = "\(Self.self)"
        return name.prefix(1).lowercased() + name.dropFirst()
    }

    public static var databaseSelection: [SQLSelectable] {
        codingKeys.map(Column.init)
    }
}
