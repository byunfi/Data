//
//  MasterDataLibraryManager.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Domain
import Foundation
import GRDB

public struct MasterDataLibraryManager {
    private let dbQueue: DatabaseQueue

    public init(databaseDirectoryURL: URL, fileName: String) {
        let databaseURL = databaseDirectoryURL.appendingPathComponent(fileName)
        self.init(databasePath: databaseURL.path)
    }

    public init(databasePath: String) {
        var config = Configuration()
        config.foreignKeysEnabled = true
        config.readonly = true
        #if DEBUG
            config.trace = { debugPrint($0) }
        #endif
        dbQueue = try! DatabaseQueue(path: databasePath, configuration: config)
    }

    public func interrupt() {
        dbQueue.interrupt()
    }
}

extension MasterDataLibraryManager {
    public func servantDetail(servantId: Int) throws -> MDServantDetailInfo {
        try dbQueue.read { db in
            let servant = try MDServantInfo.All().filter(key: servantId).fetchOne(db)!
            let treasureDevices = try MDTreasureDeviceInfo.filter(servantId: servantId).fetchAll(db)
            let skills = try MDServantSkillInfo.filter(servantId: servantId).fetchAll(db)
            let classPassives = try self.fetchServantClassPassives(db: db, servantId: servantId)
            return MDServantDetailInfo(servant: servant, treasureDevices: treasureDevices, skills: skills, classPassives: classPassives)
        }
    }

    public func servants(condition: SQLExpression? = nil,
                         orders: [SQLOrderingTerm] = []) throws -> [MDServantInfo] {
        let orders = orders.isEmpty ? [MstSvt.Columns.collectionNo] : orders

        let request = MDServantInfo
            .All()
            .filter(condition ?? true)
            .order(orders)

        return try dbQueue.read { db in
            let servants = try request.fetchAll(db)
            return servants
        }
    }

    public func servantSkills(servantId: Int) throws -> [MDServantSkillInfo] {
        try dbQueue.read { db in
            let skills = try MDServantSkillInfo.filter(servantId: servantId).fetchAll(db)
            return skills
        }
    }

    private func fetchServantClassPassives(db: Database, servantId: Int) throws -> [MDServantClassPassiveInfo] {
        let classPassiveRequest = MstSvt.select(MstSvt.Columns.classPassive)
            .filter(key: servantId)
        let classPassiveIds = try [Int].fetchOne(db, classPassiveRequest)!
        return try MDServantClassPassiveInfo.filter(skillIds: classPassiveIds).fetchAll(db)
    }

    public func servantClassPassives(servantId: Int) throws -> [MDServantClassPassiveInfo] {
        try dbQueue.read { db in
            try self.fetchServantClassPassives(db: db, servantId: servantId)
        }
    }

    public func servantTreasureDevices(servantId: Int) throws -> [MDTreasureDeviceInfo] {
        try dbQueue.read { db in
            let treasureDevices = try MDTreasureDeviceInfo.filter(servantId: servantId).fetchAll(db)
            return treasureDevices
        }
    }

    public func filterServants(name: String?,
                               genderTypes: [Int],
                               policys: [Int],
                               personalities: [Int],
                               attris: [Int],
                               individualities: [Int],
                               classIds: [Int],
                               joinIndividualities: Bool)
        throws -> [MDServantInfo] {
        var conditions: [SQLExpression] = []
        if let name = name {
            let nameCondition = Column("name").like("%\(name)%")
            conditions.append(nameCondition)
        }
        if !classIds.isEmpty {
            conditions.append(classIds.contains(Column("classId")))
        }
        if !genderTypes.isEmpty {
            conditions.append(genderTypes.contains(Column("genderType")))
        }
        if !attris.isEmpty {
            conditions.append(attris.contains(Column("attri")))
        }
        if !policys.isEmpty {
            conditions.append(policys.contains(Column("policy")))
        }
        if !personalities.isEmpty {
            conditions.append(personalities.contains(Column("personality")))
        }
        if !individualities.isEmpty {
            let op: SQLLogicalBinaryOperator = joinIndividualities ? .and : .or
            let individualityCondition = individualities.map { individuality in
                let column = Column("individuality")
                return [column.like("%,\(individuality),%"),
                        column.like("%,\(individuality)]")].joined(operator: .or)
            }.joined(operator: op)
            conditions.append(individualityCondition)
        }
        let expression = conditions.joined(operator: .and)
        return try servants(condition: expression)
    }
}

// MARK: - MasterData Model

extension MDServantClassPassiveInfo {
    static func filter(skillIds: [Int]) -> QueryInterfaceRequest<Self> {
        let request = MstSkill
            .filter(keys: skillIds)
            .including(required: MstSkill.skillDetail).asRequest(of: MDServantClassPassiveInfo.self)
        return request
    }
}

extension MDServantInfo {
    static func All() -> QueryInterfaceRequest<Self> {
        let svtlimitRequest = MstSvt.svtLimit
            .select(MstSvtLimitLite.databaseSelection)
            .filter(limitCount: 0)

        let request = MstSvt
            .select(MstSvtLite.databaseSelection)
            .including(optional: svtlimitRequest)
            .filter(type: .servant)
        return request.asRequest(of: MDServantInfo.self)
    }
}

extension MDTreasureDeviceInfo {
    static func filter(servantId: Int) -> QueryInterfaceRequest<Self> {
        let svtTreasureDeviceRequest = MstSvtTreasureDevice.treasureDevice
            .including(required: MstTreasureDevice.treasureDeviceDetail)

        let questRequest = MstSvtTreasureDevice.quest
            .select(MstQuestLite.databaseSelection)

        let request = MstSvtTreasureDevice
            .including(optional: questRequest)
            .including(required: svtTreasureDeviceRequest)
            .filter(servantId: servantId)
            .orderByNumStrengthStatusAndFlag()
        return request.asRequest(of: MDTreasureDeviceInfo.self)
    }
}

extension MDServantSkillInfo {
    static func filter(servantId: Int) -> QueryInterfaceRequest<Self> {
        let skillLvRequest = MstSkill.skillLv
            .filter(lv: 1)

        let questRequest = MstSvtSkill.quest
            .select(MstQuestLite.databaseSelection)

        let svtSkillRequest = MstSvtSkill.skill
            .including(required: MstSkill.skillDetail)
            .including(required: skillLvRequest)

        let request = MstSvtSkill
            .including(optional: questRequest)
            .including(required: svtSkillRequest)
            .filter(svtId: servantId)
            .orderByNumStrengthStatusAndFlag()
        return request.asRequest(of: MDServantSkillInfo.self)
    }
}

// MARK: - DerivableRequest

extension DerivableRequest where RowDecoder == MstSvtTreasureDevice {
    func filter(servantId: Int) -> Self {
        filter(MstSvtTreasureDevice.Columns.svtId == servantId
            && MstSvtTreasureDevice.Columns.num < 90)
    }

    func orderByNumStrengthStatusAndFlag() -> Self {
        order(MstSvtTreasureDevice.Columns.num,
              MstSvtTreasureDevice.Columns.strengthStatus,
              MstSvtTreasureDevice.Columns.flag)
    }
}

extension DerivableRequest where RowDecoder == MstSvt {
    func filter(type: MstSvtType) -> Self {
        switch type {
        case .servant:
            return filter(MstSvt.Columns.id > 100_000
                && MstSvt.Columns.id < 9_000_000
                && MstSvt.Columns.collectionNo > 0)
        case .craftEssence:
            return filter(MstSvt.Columns.type == 6
                && MstSvt.Columns.collectionNo > 0)
        case .experienceCard:
            return filter(MstSvt.Columns.type == 3)
        }
    }
}

extension DerivableRequest where RowDecoder == MstSkillLv {
    func filter(lv: Int) -> Self {
        filter(MstSkillLv.Columns.lv == lv)
    }
}

extension DerivableRequest where RowDecoder == MstSvtSkill {
    func filter(svtId: Int) -> Self {
        filter(MstSvtSkill.Columns.svtId == svtId)
    }

    func orderByNumStrengthStatusAndFlag() -> Self {
        order(MstSvtSkill.Columns.num, MstSvtSkill.Columns.strengthStatus, MstSvtSkill.Columns.flag)
    }
}

extension DerivableRequest where RowDecoder == MstSvtLimit {
    func filter(limitCount: Int) -> Self {
        filter(MstSvtLimit.Columns.limitCount == limitCount)
    }
}

enum MstSvtType {
    case servant, craftEssence, experienceCard
}
