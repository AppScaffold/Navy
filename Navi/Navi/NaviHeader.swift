//
//  Navi.swift
//  Panda
//
//  Created by chai.chai on 2018/12/28.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation
import UIKit

public typealias NaviNavigation = NaviProtocol

@objc
public class NaviHeader: NSObject {

    public static let shared = NaviHeader()

    public func setup(with navigator: NaviNavigation) {
        let recognizer = AllTouchesGestureRecognizer(navigator)
        recognizer.cancelsTouchesInView = false
        NaviManager.setup(navigator: navigator)
        let naviManager = NaviManager.shared
        naviManager().writeHTMLFileToLocal()
        naviManager().start()

        guard let window = UIApplication.shared.windows.first else {
            return
        }
        window.addGestureRecognizer(recognizer)
    }

}
