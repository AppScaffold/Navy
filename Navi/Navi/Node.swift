//
//  Node.swift
//  Panda
//
//  Created by chai.chai on 2018/12/3.
//  Copyright © 2018 Farfetch. All rights reserved.
//

struct NaviModel {
    var name: String = ""
    var parent: String = ""
    var url: String = ""
    var isCurrent = false
    var children = [NaviModel]()
}

class Node: NSObject {
    var navi: NaviModel
    var children = [Node]()
    weak var parent: Node?

    init(with navi: NaviModel) {
        self.navi = navi
    }

    func add(child: Node) {
        children.append(child)
        child.parent = self
    }
}

extension Node {
    override var description: String {
        var text = "\(navi.name)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }

    func extractData(node: Node) -> [[String:Any]] {
        var dataArray = [[String:Any]]()

        var rootDic = [String:Any]()
        rootDic["name"] = node.navi.name
        rootDic["parent"] = node.navi.parent
        rootDic["url"] = node.navi.url
        rootDic["isCurrent"] = node.navi.isCurrent
        rootDic["children"] = extractChildren(node: node)

        dataArray.append(rootDic)

        return dataArray
    }

    func extractChildren(node: Node) -> [[String:Any]] {
        var childrenArray = [[String:Any]]()

        if !node.children.isEmpty {
            node.children.forEach {
                var childrenDic = [String:Any]()

                childrenDic["name"] = $0.navi.name
                childrenDic["parent"] = $0.navi.parent
                childrenDic["url"] = $0.navi.url
                childrenDic["isCurrent"] = $0.navi.isCurrent
                childrenDic["children"] = extractChildren(node: $0)

                childrenArray.append(childrenDic)
            }
        }

        return childrenArray
    }
}

extension Node {
    func search(with name: String) -> Node? {
        if name == self.navi.name {
            return self
        }

        for child in children {
            if let found = child.search(with: name) {
                return found
            }
        }
        return nil;
    }
}
