//
//  MooncellHomeExtarctor.swift
//  
//
//  Created by byunfi on 2020/1/4.
//

import Foundation
import Kanna
import Domain

// MARK: - MooncellParser
class MooncellParser {
    
    enum SourceType: String, CustomStringConvertible {
        case CN = "cn"          // 国服数据
        case JP  = "jp"         // 日服数据
        case nextCN = "next"    // 国服预测
        
        public var description: String { rawValue }
    }
    
    /// Host URL string of `Mooncell`.
    fileprivate static let domain = "https://fgo.wiki"
    
    fileprivate let html: HTMLDocument
    
    init(_ data: Data, encoding: String.Encoding = .utf8) throws {
        html = try HTML(html: data, encoding: encoding)
    }
    
    init(_ text: String, encoding: String.Encoding = .utf8) throws {
        html = try HTML(html: text, encoding: encoding)
    }
}

// MARK: - MooncellHomeParser
class MooncellHomeParser: MooncellParser {
    
    enum ContentSection: String, CustomStringConvertible {
        case events = "home-events"         // 活动（国服、日服）
        case summons = "home-summons"       // 卡池（国服、日服）
        case newCards = "new-cards"             // 新增内容（国服、日服）x（从者强化、从者、概念礼装、指令纹章）
        case weeklyMission = "weekly-mission"   // 御主任务（国服、日服、国服预测）

        public var description: String { rawValue }
    }
    
    /// Extract target source in the section.
    /// - Parameter contentSection: Pre-defined mark for page to be parseed.
    /// - Parameter sourceType: target source.
    func parse(in contentSection: ContentSection, target sourceType: SourceType) -> [MCHomeBox] {
        let containerDivXPath = "//*[@id=\"\(contentSection)-container-\(sourceType)\"]/div"
        let subtitleXPath = "self::div[@class=\"\(contentSection)-subtitle\"]"
        var subtitle = ""
        var boxs: [MCHomeBox] = []
        for div in html.xpath(containerDivXPath) {
            // Find content section name.
            if let text = div.xpath(subtitleXPath).first?.text {
                subtitle = text
                continue
            }
            
            if let className = div.className, className.starts(with: contentSection.rawValue) {
                let aXPath = contentSection == .events ? #"span[@class="nomobile"]/a"# : "a"
                let aObject = div.xpath(aXPath)
                if aObject.count == 0 {
                    subtitle = ""
                    continue
                }
                let cards = aObject.map { a -> MCCard in
                    let title = a.xpath("@title").first?.text ?? ""
                    let href = a.xpath("@href").first?.text.map { MooncellParser.domain + $0 }
                    let imageLink = a.xpath("img/@data-src").first?.text.map { MooncellParser.domain + $0 }
                    return MCCard(title: title, imageSrc: imageLink!, href: href)
                }
                let box = MCHomeBox(sectionName: subtitle, cards: cards)
                boxs.append(box)
            }
        }
        return boxs
    }
    
    func parseMasterMission(target sourceType: SourceType) -> MCMasterMission {
        let containerPXPath = "//*[@id=\"\(ContentSection.weeklyMission)-container-\(sourceType)\"]/p"
        var descriptions: [String] = []
        var date = ""
        for p in html.xpath(containerPXPath) {
            if p.className == "weekly-mission-date", let dateText = p.text {
                date = dateText
                continue
            }
            if p.className == "weekly-mission-desc", let missionTextRaw = p.text {
                var res = missionTextRaw.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)
                res.remove(at: 0)
                descriptions.append(res.joined())
            }
        }
        let sectionName = sourceType == .nextCN ? "下周预任务预测" : "本周任务"
        let masterMission = MCMasterMission(sectionName: sectionName, date: date, missions: descriptions)
        return masterMission
    }
}

// MARK: - MooncellEventListParser
class MooncellEventListParser: MooncellParser {
    
    func parseFutureEvents() -> [MCEventListItem] {
        let trXPath = #"//*[@id="mw-content-text"]/div/table[1]/tbody/tr"#
        return html.xpath(trXPath).dropFirst().map { tr -> MCEventListItem in
            let duration = tr.xpath("td[1]/text()")
            let openDate = duration[0].text!
            let closeDate = duration[1].text!.rstrip()
            let href = tr.xpath("td[2]/a/@href").first?.text.map { MooncellParser.domain + $0 }
            let name = tr.xpath("td[2]/a/@title")[0].text!
            let imageSrc = tr.xpath("td[3]/a/img/@data-src").first?.text.map { MooncellParser.domain + $0 } ?? ""
            let type = tr.xpath("td[4]/text()").first!.text!.rstrip()
            let officialHref = tr.xpath("td[4]/a/@href").first?.text
            return MCEventListItem(openDate: String(openDate), closeDate: String(closeDate), name: name, href: href, imageSrc: imageSrc, type: type, officialHref: officialHref)
        }
    }
}

private extension String {
    func rstrip() -> Self {
        if self[index(before: self.endIndex)] == "\n" {
            return String(dropLast())
        }
        return self
    }
}
