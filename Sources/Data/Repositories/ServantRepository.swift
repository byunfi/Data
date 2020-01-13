//
//  ServantRepository.swift
//
//
//  Created by byunfi on 2020/1/7.
//

import Domain
import Foundation
import RxSwift

final class DefaultServantRepository: ServantRepository {
    let masterData: MasterDataLibraryManager
    let gameURLService: GameImageResourceURL

    init(masterData: MasterDataLibraryManager, gameURLService: GameImageResourceURL) {
        self.masterData = masterData
        self.gameURLService = gameURLService
    }

    func servantsList(name: String?,
                      genderTypes: [ServantGender],
                      policys: [ServantPolicy],
                      personalities: [ServantPersonality],
                      attris: [ServantAttri],
                      classes: [ServantClass],
                      individualities: [ServantIndividuality],
                      joinIndividualities: Bool)
        -> Observable<[Servant]> {
        Observable<[Servant]>.create { [weak self] observer in
            if let self = self {
                do {
                    let servants = try self.masterData.filterServants(name: name,
                                                                      genderTypes: genderTypes.map { $0.columnValue },
                                                                      policys: policys.flatMap { $0.columnValue },
                                                                      personalities: personalities.map { $0.columnValue },
                                                                      attris: attris.map { $0.columnValue },
                                                                      individualities: individualities.map { $0.columnValue },
                                                                      classIds: classes.map { $0.columnValue },
                                                                      joinIndividualities: joinIndividualities)
                        .map {
                            Servant.map(info: $0, gameURLService: self.gameURLService)
                        }
                    observer.onNext(servants)
                } catch {
                    observer.onError(error)
                }
            }

            return Disposables.create()
        }
    }

    func servantDetail(_ servantId: Int) -> Observable<ServantDetail> {
        Observable<ServantDetail>.create { [weak self] observer in
            guard let self = self else {
                fatalError("self deinted.")
            }
            do {
                let info = try self.masterData.servantDetail(servantId: servantId)
                let servantDetail = ServantDetail.map(info: info, gameURLService: self.gameURLService)
                observer.onNext(servantDetail)
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    func servantVoices(_: Int) -> Observable<[ServantVoice]> {
        // TODO: - fix
        Observable.never()
    }

    func servantBondStories(_: Int) -> Observable<[ServantBondStory]> {
        // TODO: - fix
        Observable.never()
    }
}

// MARK: - ColumnQuery

protocol ColumnQuery {
    associatedtype FieldType
    static var fieldName: String { get }
    var columnValue: FieldType { get }
}

extension ServantGender: ColumnQuery {
    static var fieldName: String {
        "genderType"
    }

    var columnValue: Int {
        switch self {
        case .男性:
            return 1
        case .女性:
            return 2
        case .其他:
            return 3
        }
    }
}

extension ServantPolicy: ColumnQuery {
    static var fieldName: String {
        "policy"
    }

    var columnValue: [Int] {
        switch self {
        case .中立:
            return [1, 6]
        case .混沌:
            return [2]
        case .秩序:
            return [3]
        }
    }
}

extension ServantPersonality: ColumnQuery {
    static var fieldName: String {
        "personality"
    }

    var columnValue: Int {
        switch self {
        case .善:
            return 1
        case .恶:
            return 2
        case .狂:
            return 4
        case .中庸:
            return 5
        case .花嫁:
            return 7
        case .夏:
            return 8
        }
    }
}

extension ServantAttri: ColumnQuery {
    static var fieldName: String {
        "attri"
    }

    var columnValue: Int {
        switch self {
        case .人:
            return 1
        case .天:
            return 2
        case .地:
            return 3
        case .星:
            return 4
        case .兽:
            return 5
        }
    }
}

extension ServantIndividuality: ColumnQuery {
    static var fieldName: String {
        "individuality"
    }

    var columnValue: Int {
        switch self {
        case .龙:
            return 2002
        case .骑乘:
            return 2009
        case .神性:
            return 2040
        case .魔性:
            return 2019
        case .王:
            return 2113
        case .罗马:
            return 2004
        case .亚瑟:
            return 2010
        case .死灵与恶魔:
            return 2018
        case .所爱之人:
            return 2012
        case .希腊神话男性:
            return 2114
        case .被EA特攻:
            return 2008
        case .伊莉雅:
            return 2335
        }
    }
}

extension ServantClass: ColumnQuery {
    static var fieldName: String {
        "classId"
    }

    var columnValue: Int {
        switch self {
        case .剑:
            return 1
        case .弓:
            return 2
        case .枪:
            return 3
        case .骑:
            return 4
        case .术:
            return 5
        case .杀:
            return 6
        case .狂:
            return 7
        case .盾:
            return 8
        case .裁定者:
            return 9
        case .他人格:
            return 10
        case .复仇:
            return 11
        case .月癌:
            return 23
        case .降临者:
            return 25
        }
    }
}
