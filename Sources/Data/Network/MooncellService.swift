//
//  MooncellService.swift
//  
//
//  Created by byunfi on 2020/1/4.
//

import UIKit
import Moya

enum MooncellService {
    case home
    case eventList
}

extension MooncellService: TargetType {
    var baseURL: URL {
        URL(string: "https://fgo.wiki")!
    }
    
    var path: String {
        "/index.php"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        var title: String
        switch self {
        case .home:
            title = "首页"
        case .eventList:
            title = "活动一览"
        }
        return .requestParameters(parameters: ["title": title , "mobileaction": "toggle_view_desktop"], encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS \(UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"]
    }
  
}
