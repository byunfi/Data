//
//  File.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain

extension CLEffect {
    static func map(info: MDDetailInfo) -> [CLEffect] {
        return zip(info.detail, info.value).map(CLEffect.init)
    }
}
