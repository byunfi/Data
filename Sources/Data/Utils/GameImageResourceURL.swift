//
//  Kazemai.swift
//  
//
//  Created by byunfi on 2020/1/8.
//

import Foundation

struct KazemaiURL: GameImageResourceURL {
    private static let imageRoot = "https://kazemai.github.io/fgo-vz/common/images"
    
    func servantFace(_ id: Int, stage: Int = 0) -> String {
        "\(KazemaiURL.imageRoot)/icon/faces/\(id)\(stage).png"
    }
    
    func craftFace(_ id: Int) -> String {
        "\(KazemaiURL.imageRoot)/icon/faces/\(id).png"
    }
    
    func skill(_ id: Int) -> String {
        "\(KazemaiURL.imageRoot)/icon/items/\(id).png"
    }
    
    func item(_ id: Int) -> String {
        "\(KazemaiURL.imageRoot)/SkillIcon/SkillIcon_\(id).png"
    }
}

protocol GameImageResourceURL {
    func servantFace(_ id: Int, stage: Int) -> String
    func craftFace(_ id: Int) -> String
    func skill(_ id: Int) -> String
    func item(_ id: Int) -> String
}
