//
//  MCMasterMission+DomainMapping.swift
//  
//
//  Created by byunfi on 2020/1/8.
//

import Foundation
import Domain

extension GameMasterMission {
    static func map(mission: MCMasterMission) -> GameMasterMission {
        GameMasterMission(duration: mission.date, missionDescriptions: mission.missions, when: mission.sectionName)
    }
}
