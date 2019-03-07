//
//  MusicViewController.swift
//  NaviDemo
//
//  Created by chai.chai on 2019/1/9.
//  Copyright © 2019 chai.chai. All rights reserved.
//

import Foundation
import UIKit

class MusicViewController: UIViewController {

    override func viewDidLoad() {
        title = "Music"
        view.backgroundColor = UIColor.white
    }
    
    private func configureSubViews() {
        let button: UIButton = {
            let button = UIButton(type: .custom)
            button.frame = CGRect.init(x: 100, y: 200, width: view.frame.size.width - 200, height: 100)
            button.setTitle("go to Movie", for: .normal)
            button.backgroundColor = UIColor.orange
            button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            return button
        }()

        view.addSubview(button)
    }

    @objc
    func clickButton() {
        navigationController?.pushViewController(MovieViewController(), animated: true)
    }
}
