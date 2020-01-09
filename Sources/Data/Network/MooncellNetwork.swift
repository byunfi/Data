//
//  MooncellNetwork.swift
//  
//
//  Created by byunfi on 2020/1/8.
//

import Foundation
import Domain
import Moya

public struct MooncellNetwork {
    private let provider = MoyaProvider<MooncellAPI>()
    
    public func homeData(completion: @escaping (Result<MCHomeSourceData, MoyaError>) -> Void) -> Cancellable {
        return provider.request(.home) { result in
            let newResult = result.map { response -> MCHomeSourceData in
                guard let parser = try? MooncellHomeParser(response.data) else {
                    fatalError("Cannot decode Mooncell page: <首页>.")
                }
                
                func parseData(targetType: MooncellHomeParser.SourceType) -> MCHomeData {
                    let newCards = parser.parse(in: .newCards, target: targetType)
                    let events = parser.parse(in: .events, target: targetType)
                    let summons = parser.parse(in: .summons, target: targetType)
                    let masterMissions = targetType == .CN ?
                        [parser.parseMasterMission(target: .CN), parser.parseMasterMission(target: .nextCN)] :
                        [parser.parseMasterMission(target: .JP)]
                    return MCHomeData(events: events,
                                      summons: summons,
                                      recentlyUpdatedData: newCards,
                                      masterMissions: masterMissions)
                }
                let cnData = parseData(targetType: .CN)
                let jpData = parseData(targetType: .JP)
                return MCHomeSourceData(cn: cnData, jp: jpData)
            }
            completion(newResult)
        }
    }
    
    public func eventList(completion: @escaping (Result<[MCEventListItem], MoyaError>) -> Void) -> Cancellable {
        provider.request(.eventList) { result in
            let newResult = result.map { response -> [MCEventListItem] in
                guard let parser = try? MooncellEventListParser(response.data) else {
                    fatalError("Cannot decode Mooncell page: <活动一览>.")
                }
                return parser.parseFutureEvents()
            }
            completion(newResult)
        }
    }
}
