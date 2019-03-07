//
//  DetailViewController.swift
//  NaviDemo
//
//  Created by chai.chai on 2019/1/9.
//  Copyright © 2019 chai.chai. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        title = "Detail"
        view.backgroundColor = UIColor.white
        configureSubViews()
    }

    private func configureSubViews() {
        let button: UIButton = {
            let button = UIButton(type: .custom)
            button.frame = CGRect.init(x: 100, y: 200, width: view.frame.size.width - 200, height: 100)
            button.setTitle("present Setting ViewController", for: .normal)
            button.backgroundColor = UIColor.orange
            button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            return button
        }()

        view.addSubview(button)
    }

    @objc
    func clickButton() {
        let navigationController = UINavigationController(rootViewController: SettingViewController())
        present(navigationController, animated: true, completion: nil)
    }
}
