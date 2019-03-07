//
//  Navigation.swift
//  NaviDemo
//
//  Created by chai.chai on 2019/1/8.
//  Copyright © 2019 chai.chai. All rights reserved.
//

import Foundation
import Navy

class Navigation: NaviProtocol {
    func rootNodeName() -> String {
        return "NavyDemo"
    }
    
    func tabBarViewControllers() -> [String] {
        return ["NavyDemo.FavoriteViewController", "NavyDemo.DownloadViewController", "NavyDemo.HistoryViewController"]
    }

    func mapBusinessLogicDocument() -> [String: String] {
        return ["NavyDemo.FavoriteViewController": "https://en.wikipedia.org/wiki/Marie_Curie",
                "NavyDemo.ListViewController": "https://en.wikipedia.org/wiki/Albert_Einstein",
                "NavyDemo.DetailViewController": "https://en.wikipedia.org/wiki/Tu_Youyou",
                "NavyDemo.SettingViewController": "https://en.wikipedia.org/wiki/Alan_Turing",
                "NavyDemo.DownloadViewController": "https://en.wikipedia.org/wiki/Main_Page"]
    }
}
