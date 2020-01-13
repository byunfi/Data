//
//  MCHomeBox+DomainMapping.swift
//
//
//  Created by byunfi on 2020/1/8.
//

import Domain
import Foundation

extension GameActivity {
    static func map(box: MCHomeBox) -> [GameActivity] {
        box.cards.map { card in
            GameActivity(name: card.title, noticeURL: nil, bannerImageURL: card.imageSrc, wikiRefrenceURL: card.href, when: box.sectionName)
        }
    }
}

extension GameCard {
    static func map(box: MCHomeBox) -> [GameCard] {
        box.cards.map { card in
            GameCard(sectionName: box.sectionName, name: card.title, faceImageURL: card.imageSrc, wikiRefrenceURL: card.href)
        }
    }
}
