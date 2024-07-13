//
//  BaseViewController.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backButtonDisplayMode = .minimal
        configureNavigationBar()
        addSubviews()
        configureLayout()
        configureView()
    }
    
    func configureNavigationBar() {}
    func addSubviews() {}
    func configureLayout() {}
    func configureView() {}
}
