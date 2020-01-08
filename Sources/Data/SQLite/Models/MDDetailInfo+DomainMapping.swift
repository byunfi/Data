//
//  File.swift
//  
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain

extension ServantActionEffect {
    static func map(info: MDDetailInfo) -> [ServantActionEffect] {
        return zip(info.detail, info.value).map(ServantActionEffect.init)
    }
}
