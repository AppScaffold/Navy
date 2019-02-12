//
//  NaviProtocol.swift
//  Navi
//
//  Created by chai.chai on 2019/1/9.
//

import Foundation

@objc
public protocol NaviProtocol: class {
    func tabBarViewControllers() -> [String]
    func rootNodeName() -> String
    func mapBusinessLogicDocument() -> [String: String]
}
