//
//  MonncellHomeNetwok.swift
//  
//
//  Created by byunfi on 2020/1/4.
//

import Foundation
import Moya
import RxMoya
import RxSwift
import Domain

final public class MonncellNetwok {
    private let provider: MoyaProvider<MooncellService>
    
    init(provider: MoyaProvider<MooncellService>) {
        self.provider = provider
    }
    
    public func fetchHomeData() -> Single<[MCHomeData]> {
        provider.rx.request(.home).map { response in
            guard let extractor = try? MooncellHomeExtractor(response.data) else {
                fatalError("Cannot decode Mooncell page: <首页>.")
            }
            
            func extractData(targetType: MooncellExtractor.SourceType) -> MCHomeData {
                let recentGameData = extractor.extract(in: .newCards, target: targetType)
                let events = extractor.extract(in: .events, target: targetType)
                let summons = extractor.extract(in: .summons, target: targetType)
                let masterMission = targetType == .CN ? [
                extractor.extractMasterMission(target: .CN),
                extractor.extractMasterMission(target: .nextCN)] : [extractor.extractMasterMission(target: .JP)]
                return MCHomeData(sourceType: MCHomeSourceType(rawValue: targetType.description.uppercased())!, events: events, summons: summons, recentlyUpdatedData: recentGameData, masterMissions: masterMission)
            }
            let cnData = extractData(targetType: .CN)
            let jpData = extractData(targetType: .JP)
            return [cnData, jpData]
        }
    }
    
    public func fetchEventList() -> Single<[MCEventListItem]> {
        provider.rx.request(.eventList).map { response in
            guard let extractor = try? MooncellEventListExtractor(response.data) else {
                fatalError("Cannot decode Mooncell page:  <活动一览>.")
            }
            return extractor.extarctFutureEvents()
        }
    }
}
