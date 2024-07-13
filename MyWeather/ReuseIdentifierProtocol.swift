//
//  ReuseIdentifierProtocol.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit

protocol ReuseIdentifierProtocol: AnyObject {
    static var identifier: String { get }
}

extension BaseCollectionViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension BaseTableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
