//
//  DefaultHomeUseCase.swift
//  
//
//  Created by byunfi on 2020/1/4.
//

import Foundation
import Domain
import RxSwift

final class DefaultHomeUseCase: HomeUseCase {
    private let network: MonncellNetwok
    
    init(network: MonncellNetwok) {
        self.network = network
    }
    
    func homeData() -> Single<[MCHomeData]> {
        network.fetchHomeData()
    }
}
