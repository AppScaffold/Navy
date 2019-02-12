//
//  HomeViewController.swift
//  NaviDemo
//
//  Created by chai.chai on 2019/1/8.
//  Copyright © 2019 chai.chai. All rights reserved.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        configureSubViews()
    }

    private func configureSubViews() {
        let button: UIButton = {
            let button = UIButton(type: .custom)
            button.frame = CGRect.init(x: 100, y: 200, width: view.frame.size.width - 200, height: 100)
            button.setTitle("go to list", for: .normal)
            button.backgroundColor = UIColor.orange
            button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            return button
        }()

        view.addSubview(button)
    }

    @objc
    func clickButton() {
        navigationController?.pushViewController(ListViewController(), animated: true)
    }
}
