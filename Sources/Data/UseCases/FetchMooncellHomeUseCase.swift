//
//  HomeUseCase.swift
//  
//
//  Created by byunfi on 2020/1/4.
//

import Foundation
import Domain
import RxSwift

final class DefaultHomeUseCase: FetchMooncellHomeUseCase {
    private let network: MonncellNetwork
    
    init(network: MonncellNetwork) {
        self.network = network
    }
    
    func homeData() -> Single<[MCHomeData]> {
        network.fetchHomeData()
    }
}
