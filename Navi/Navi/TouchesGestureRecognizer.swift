//
//  AllTouchesGestureRecognizer.swift
//  Panda
//
//  Created by chai.chai on 2018/12/26.
//  Copyright © 2018 Farfetch. All rights reserved.
//

@objc
class TouchesGestureRecognizer: UITapGestureRecognizer {
    var navigator: NaviNavigation
    init(with navigator: NaviNavigation) {
        self.navigator = navigator
        super.init(target: nil, action: nil)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let view = touches.first?.view else { return }
        let className = NSStringFromClass(view.classForCoder)
        var actionString = "";

        if view.isKind(of: UIButton.classForCoder()) {
            let button = view as! UIButton
            for target in button.allTargets {
                actionString = button.actions(forTarget: target, forControlEvent: button.allControlEvents)?.first ?? ""
            }
            actionString = className + actionString
            NaviManager.shared().addEventsNode(with: className, actionString: actionString)

        } else if let gesture = view.gestureRecognizers?.first {
            guard let targets = gesture.value(forKey: "_targets") else { return }
            guard let targetContainer = (targets as! [AnyObject]).first else { return }
            let targetClass = object_getClass(targetContainer)
            guard let ivar = class_getInstanceVariable(targetClass, "_action") else { return }
            let action = object_getIvar(targetContainer, ivar)
            actionString = String(format: "%s", sel_getName(action as! Selector))

            actionString = className + actionString
            NaviManager.shared().addEventsNode(with: className, actionString: actionString)

        } else {
            // touch events
        }

        super.touchesEnded(touches, with: event)
    }
}
