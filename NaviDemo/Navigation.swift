//
//  Navigation.swift
//  NaviDemo
//
//  Created by chai.chai on 2019/1/8.
//  Copyright © 2019 chai.chai. All rights reserved.
//

import Foundation
import Navi

class Navigation: NaviProtocol {
    func rootNodeName() -> String {
        return "NaivDemo"
    }
    
    func tabBarViewControllers() -> [String] {
        return ["NaviDemo.FavoriteViewController", "NaviDemo.DownloadViewController", "NaviDemo.HistoryViewController"]
    }

    func mapBusinessLogicDocument() -> [String: String] {
        return ["NaviDemo.FavoriteViewController": "https://en.wikipedia.org/wiki/Marie_Curie",
                "NaviDemo.ListViewController": "https://en.wikipedia.org/wiki/Albert_Einstein",
                "NaviDemo.DetailViewController": "https://en.wikipedia.org/wiki/Tu_Youyou",
                "NaviDemo.SettingViewController": "https://en.wikipedia.org/wiki/Alan_Turing",
                "NaviDemo.DownloadViewController": "https://en.wikipedia.org/wiki/Main_Page"]
    }
}
