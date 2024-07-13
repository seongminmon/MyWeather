//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let id = "WeatherTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
