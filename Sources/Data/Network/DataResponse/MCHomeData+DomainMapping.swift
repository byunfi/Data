//
//  File.swift
//  
//
//  Created by byunfi on 2020/1/8.
//

import Foundation
import Domain

extension GameRecentData {
    static func map(homeData: MCHomeData) -> GameRecentData {
        GameRecentData(events: homeData.events.flatMap(GameActivity.map(box:)),
                       summons: homeData.summons.flatMap(GameActivity.map(box:)),
                       masterMissions: homeData.masterMissions.map(GameMasterMission.map(mission:)),
                       newCards: homeData.recentlyUpdatedData.flatMap(GameCard.map(box:)))
    }
    
}
