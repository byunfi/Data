//
//  File.swift
//
//
//  Created by byunfi on 2020/1/5.
//

import Foundation
import Domain
import GRDB

public class MasterData {
    
    fileprivate let dbQueue: DatabaseQueue

    public convenience init(databaseDirectoryURL: URL, fileName: String) {
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
}

extension MasterData {

    public func questName(id: Int) throws -> String? {
        return try dbQueue.read { db in
            let request = MstQuest.select(Column("name") ?? Column("jpName")).filter(Column("id")==id)
            return try String.fetchOne(db, request)
        }
    }

    public func treasureDevices(svtId: Int) throws -> [MDTreasureDeviceInfo] {
        return try dbQueue.read { db in
            let request = MDTreasureDeviceInfo.filter(svtId: svtId)
            return try request.fetchAll(db)
        }
    }

    public func ownedSkills(svtId: Int) throws -> [MDOwnedSkillInfo] {
        return try dbQueue.read { db in
            let request = MDOwnedSkillInfo.filter(svtId: svtId)
            return try request.fetchAll(db)
        }
    }

    public func classSkills(svtId: Int) throws -> [MDClassSkillInfo] {
        return try dbQueue.read { db in
            return try fetchClassSkills(db, svtId: svtId)
        }
    }

    private func fetchClassSkills(_ db: Database, svtId: Int) throws -> [MDClassSkillInfo] {
        let classPassiveRequest = MstSvt.select(Column("classPassive"), as: [Int].self)
            .filter(Column("id")==svtId)
        let classPassives = try classPassiveRequest.fetchOne(db)!
        return try MDClassSkillInfo.filter(skillIds: classPassives).fetchAll(db)
    }

    public func servant(svtId: Int) throws -> MDServantDetailInfo {
        try dbQueue.read { db in
            let servant = try MDServantInfo.filter(svtId: svtId).fetchOne(db)!
            let treasureDevices = try MDTreasureDeviceInfo.filter(svtId: svtId).fetchAll(db)
            let ownedSkills = try MDOwnedSkillInfo.filter(svtId: svtId).fetchAll(db)
            let classSkills = try fetchClassSkills(db, svtId: svtId)
            return MDServantDetailInfo(servant: servant, treasureDevices: treasureDevices, ownedSkills: ownedSkills, classSkills: classSkills)
        }
    }
    
    public func servants(condition: SQLExpression?, orders: [SQLOrderingTerm] = [Column("collectionNo")]) throws -> [MDServantInfo] {
        let limitRequest = MstSvt.svtLimit
            .select(Column("rarity"))
            .filter(Column("limitCount")==0)
            .forKey("svtLimitInfo")
        let request = MstSvt.servants
            .including(optional: limitRequest)
            .filter(condition ?? true)
            .order(orders)
        return try dbQueue.read { db in
            let servants = try MDServantInfo.fetchAll(db, request)
            return servants
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

extension MDTreasureDeviceInfo {
    static func filter(svtId: Int) -> QueryInterfaceRequest<Self> {
        let treasureDeviceRequest = MstSvtTreasureDevice.treasureDevice
            .including(required: MstTreasureDevice.detail.forKey("detailInfo"))
            .forKey("treasureDeviceInfo")
        let request = MstSvtTreasureDevice
            .including(optional: MstSvtTreasureDevice.quest.forKey("questInfo"))
            .including(required: treasureDeviceRequest)
            .filter(Column("svtId")==svtId && Column("num") < 90)
            .order(Column("strengthStatus"), Column("flag"))
        return request.asRequest(of: Self.self)
    }
}

extension MDOwnedSkillInfo {
    static func filter(svtId: Int) -> QueryInterfaceRequest<Self> {
        let skillRequest = MstSvtSkill.skill
            .including(required: MstSkill.detail.forKey("detailInfo"))
            .including(required: MstSkill.lv.filter(Column("lv")==1).forKey("skillLvInfo"))
            .forKey("skillInfo")
        let request = MstSvtSkill
            .including(optional: MstSvtSkill.quest.forKey("questInfo"))
            .including(required: skillRequest)
            .filter(Column("svtId")==svtId)
            .order(Column("num"), Column("strengthStatus"), Column("flag"))
        return request.asRequest(of: Self.self)
    }
}

extension MDClassSkillInfo {
    static func filter(skillIds: [Int]) -> QueryInterfaceRequest<Self> {
        let request = MstSkill.filter(keys: skillIds)
            .select(Column("id"), Column("name"), Column("jpName"), Column("iconId"))
            .including(required: MstSkill.detail.forKey("detailInfo"))
        return request.asRequest(of: Self.self)
    }
}

extension MDServantInfo {
    static func filter(svtId: Int) -> QueryInterfaceRequest<Self> {
        let limitRequest = MstSvt.svtLimit
            .select(Column("rarity"))
            .filter(Column("limitCount")==0)
            .forKey("svtLimitInfo")
        let request = MstSvt.servants
            .filter(key: svtId)
            .including(optional: limitRequest)
            .order(Column("collectionNo"))
        return request.asRequest(of: Self.self)
    }
}

protocol ColumnQuery {
    associatedtype FieldType
    var fieldName: String { get }
    var columnValue: FieldType { get }
}




