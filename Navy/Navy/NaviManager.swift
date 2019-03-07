
//  NaviManager.swift
//  Panda
//
//  Created by chai.chai on 2018/12/21.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation
import UIKit

@objc
public class NaviManager: NSObject {

    private var timer: Timer?
    private var currentViewController: UIViewController?
    private var previousViewController: UIViewController?
    private var currentCount = 0
    private var previousCount = 0
    private var root: Node?
    private var navigator: NaviNavigation
    private var tabBarControllers = [String]()
    private var navigationController: UINavigationController?
    private var businessLogicMap: [String: String]?

    public static let _shared = NaviManager()

    @objc
    public class func shared() -> NaviManager {
        return NaviManager._shared
    }

    private override init() {
        guard let navigator = NaviManager.config.navigator else {
            fatalError("⚠️Error - you must call setup before accessing NaviManager.shared")
        }
        self.navigator = navigator
        self.tabBarControllers = navigator.tabBarViewControllers()
        self.businessLogicMap = navigator.mapBusinessLogicDocument()
    }

    deinit {
        print("navi manager was freed")
    }

    private class Config {
        var navigator: NaviNavigation?
    }

    private static let config = Config()

    class func setup(navigator: NaviNavigation) {
        NaviManager.config.navigator = navigator
    }

    @objc(addEventsNode:actionString:)
    public func addEventsNode(with className: String, actionString: String) {
        guard let currentViewController = currentViewController else { return }

        insertNode(with: Node(with: NaviModel(name: actionString, parent: NSStringFromClass(currentViewController.classForCoder), url:"", isCurrent: false, children: [NaviModel]())))
        writeTreeDataToLocalDocumentDirectory()
    }

    func insertNode(with child: Node) {
        let found = root?.search(with: child.navi.parent)
        found?.navi.isCurrent = false

        if isInsertATabBarController(with: child.navi.name) {
            root?.add(child: child)
            return
        }

        found?.add(child: child)
    }

    func removeNode(with child: Node) {
        guard let found = root?.search(with: child.navi.parent) else {
            return
        }
        found.children = []
        found.navi.isCurrent = true
    }
}

extension NaviManager {

    private class TimerTargetWrapper {

        var navi: NaviManager

        init(navi: NaviManager) {

            self.navi = navi
        }

        @objc
        func timerFunction(timer: Timer) {

            navi.updateTreeData()
        }
    }

    @objc(start)
    func start() {

        guard timer == nil else { return }

        timer = Timer.scheduledTimer(timeInterval: 1, target: TimerTargetWrapper(navi: self), selector: #selector(TimerTargetWrapper.timerFunction(timer:)), userInfo: nil, repeats: true)

        guard let timer = timer else { return }

        RunLoop.current.add(timer, forMode: .common)
    }

    func stop() {

        guard let timer = timer else { return }

        timer.invalidate()
        self.timer = nil
    }

    func isInsertATabBarController(with classString: String) -> Bool {
        for name in tabBarControllers {
            if name == classString && root?.search(with: name) == nil {
                return true
            }
        }

        return false
    }



    private func updateTreeData() {
        if root == nil {
            var navi = NaviModel()
            navi.name = navigator.rootNodeName()
            root = Node(with: navi)

            return
        }

        if currentViewController != topViewController() {
            let isChangedTabBar = isChangedTabBarController()

            if isPresented() {
                previousCount += 1
                currentCount += 1
                previousViewController = currentViewController
            }
            else if isChangedTabBar {
                previousCount = currentCount
                currentCount = currentNavigationStackCount()
                previousViewController = currentViewController
            }
            else {
                previousCount = currentCount
                currentCount = currentNavigationStackCount()
                previousViewController = previousController()
            }

            print("current controller: \(String(describing: currentViewController))")
            print("top view controller: \(String(describing: topViewController()))")
            print("current count: \(currentCount)")
            print("previous count:\(previousCount)")

            currentViewController = topViewController()

            guard let currentViewController = currentViewController else { return }
            let currentViewControllerString = NSStringFromClass(currentViewController.classForCoder)

            guard let previousViewController = previousViewController else { return }
            let previousViewControllerString = NSStringFromClass(previousViewController.classForCoder)

            let link = businessLogicMap?[currentViewControllerString] ?? ""

            let preNode = root?.search(with: previousViewControllerString)
            preNode?.navi.isCurrent = false

            let curNode = root?.search(with: currentViewControllerString)
            curNode?.navi.isCurrent = true

            if isInsertATabBarController(with: currentViewControllerString) {
                insertNode(with: Node(with: NaviModel(name: currentViewControllerString, parent: previousViewControllerString, url: link, isCurrent: true, children: [NaviModel]())))
                writeTreeDataToLocalDocumentDirectory()
                return
            }

            if isChangedTabBar {
                writeTreeDataToLocalDocumentDirectory()
                return
            }

            if currentCount > previousCount {
                insertNode(with: Node(with: NaviModel(name: currentViewControllerString, parent: previousViewControllerString, url: link, isCurrent: true, children: [NaviModel]())))
            } else {
                removeNode(with: Node(with: NaviModel(name: previousViewControllerString, parent: currentViewControllerString, url: "", isCurrent: false, children: [NaviModel]())))
            }

            writeTreeDataToLocalDocumentDirectory()
        }
    }
}

extension NaviManager {
    func writeTreeDataToLocalDocumentDirectory() {
        guard let root = root else { return }
        let dataArray = root.extractData(node: root)

        let file = "treeData.json"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = dir.appendingPathComponent(file)
            print("filePath: \(filePath)")

            guard let data = try? JSONSerialization.data(withJSONObject: dataArray, options: []) else {
                return
            }

            do {
                try data.write(to: filePath)
            }
            catch { /**/ }
        }
    }

    func writeHTMLFileToLocal() {
        let file = "index.html"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = dir.appendingPathComponent(file)
            print("index.html Path: \(filePath)")

            let htmlFile = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: nil)
            let htmlString = try? String(contentsOfFile: htmlFile ?? "", encoding: .utf8)

            do {
                try htmlString?.write(to: filePath, atomically: false, encoding: .utf8)
            }
            catch { /* error handling here */ }
        }
      }
}

extension NaviManager {
    func previousController() -> UIViewController? {
        if let previousVC = navigator.previousController?() {
            return previousVC
        }
        let count = topViewController()?.navigationController?.viewControllers.count ?? 0
        if count > 1 {
            return topViewController()?.navigationController?.viewControllers[count - 2]
        } else {
            return topViewController()
        }
    }

    func topViewController() -> UIViewController? {
        if let topVC = navigator.currentController?() {
            return topVC
        }
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        return visibleViewController(rootViewController)
    }

    func visibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        if rootViewController.isKind(of: UINavigationController.self) {
            let navigationController = rootViewController as! UINavigationController
            return navigationController.viewControllers.last!
        }

        if rootViewController.isKind(of: UITabBarController.self) {
            let tabBarController = rootViewController as! UITabBarController
            let selectedViewController = tabBarController.selectedViewController

            if let presentedViewController = selectedViewController?.presentedViewController {
                let navigationController = presentedViewController as! UINavigationController
                return navigationController.viewControllers.last
            }

            if (selectedViewController?.isKind(of: UINavigationController.self))! {
                let navigationController = selectedViewController as! UINavigationController
                return navigationController.viewControllers.last
            }
            return tabBarController.selectedViewController!
        }

        return nil
    }

    func currentNavigationStackCount() -> Int {
        guard let topViewController = topViewController(),
            let count = topViewController.navigationController?.viewControllers.count else {
                return 0
        }
        return count
    }

    func isChangedTabBarController() -> Bool {
        var navigationVC: UINavigationController?
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return false }
        if rootViewController.isKind(of: UINavigationController.self) {
            navigationVC = rootViewController as? UINavigationController
        }

        if rootViewController.isKind(of: UITabBarController.self) {
            let tabBarController = rootViewController as! UITabBarController
            let selectedViewController = tabBarController.selectedViewController

            if (selectedViewController?.isKind(of: UINavigationController.self))! {
                navigationVC = selectedViewController as? UINavigationController
            }
        }

        if navigationController == nil {
            navigationController = navigationVC
            return false
        }

        if !navigationVC!.isEqual(navigationController) {
            navigationController = navigationVC
            return true
        }
        return false
    }

    func isPresented() -> Bool {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return false }
        if rootViewController.isKind(of: UITabBarController.self) {
            let tabBarController = rootViewController as! UITabBarController
            let selectedViewController = tabBarController.selectedViewController

            if let _ = selectedViewController?.presentedViewController {
                return true
            }
        }
        return false
    }
}

