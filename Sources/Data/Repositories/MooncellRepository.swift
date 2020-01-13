//
//  MooncellRepository.swift
//
//
//  Created by byunfi on 2020/1/8.
//

import Domain
import Foundation
import RxSwift

public class DefaultMooncellRepository: MooncellRepository {
    private let network: MooncellNetwork

    private var isDirtyHomeCache = true

    private var cache: [String: Any] = [:]

    private var fetchHomeDataTriggerSubject = PublishSubject<Void>()

    private var fetchHomeDataSubject: Observable<[GameRecentData]>?

    public init(network: MooncellNetwork) {
        self.network = network
    }

    public func fetchHomeData(targetSource source: GameSourceType) -> Single<GameRecentData> {
        Single<GameRecentData>.create { [weak self] single in
            guard let self = self else {
                fatalError("self deinted.")
            }
            if !self.isDirtyHomeCache {
                if let homeDataCache = self.cache[source.rawValue] as? GameRecentData {
                    single(.success(homeDataCache))
                } else {
                    self.isDirtyHomeCache = true
                }
            }
            let task = self.network.homeData { result in
                switch result {
                case let .success(homeData):
                    let cnData = GameRecentData.map(homeData: homeData.cn)
                    let jpData = GameRecentData.map(homeData: homeData.jp)
                    self.cache[GameSourceType.CN.rawValue] = cnData
                    self.cache[GameSourceType.JP.rawValue] = jpData
                    let data = source == .CN ? cnData : jpData
                    self.isDirtyHomeCache = false
                    single(.success(data))
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }

    public func fetchEventList() -> Single<[GameEventDetail]> {
        Single<[GameEventDetail]>.create { [weak self] single in
            guard let self = self else {
                fatalError("self deinted.")
            }
            let task = self.network.eventList { result in
                switch result {
                case let .success(events):
                    let gameEvent = events.map(GameEventDetail.map(item:))
                    single(.success(gameEvent))
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }

    public func refreshHome() {
        isDirtyHomeCache = true
    }
}
