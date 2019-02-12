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
        return ["NaviDemo.FavoriteViewController": "https://www.farfetch.com",
                "NaviDemo.ListViewController": "https://www.farfetch.com",
                "NaviDemo.DetailViewController": "https://www.farfetch.com",
                "NaviDemo.SettingViewController": "https://www.farfetch.com",
                "NaviDemo.DownloadViewController": "https://www.farfetch.com"]
    }
}
