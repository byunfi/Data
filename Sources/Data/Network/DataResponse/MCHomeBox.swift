//
//  File.swift
//  
//
//  Created by byunfi on 2020/1/8.
//

import Foundation

public struct MCHomeBox {
    public let sectionName: String
    public let cards: [MCCard]
}

public struct MCCard {
    public let title: String
    public let imageSrc: String
    public let href: String?
}
