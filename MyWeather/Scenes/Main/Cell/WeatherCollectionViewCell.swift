//
//  WeatherCollectionViewCell.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit
import Kingfisher
import SnapKit
import Then

class WeatherCollectionViewCell: BaseCollectionViewCell {
    
    let hourLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .center
    }
    
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let tempLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .center
    }
    
    override func addSubviews() {
        contentView.addSubview(hourLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(tempLabel)
    }
    
    override func configureLayout() {
        hourLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        tempLabel.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureCell(data: List?) {
        guard let data else { return }
        hourLabel.text = data.hour
        let icon = data.weather.first?.icon ?? ""
        let url = URL(string: APIURL.iconURL + icon + "@2x.png")
        iconImageView.kf.setImage(with: url)
        tempLabel.text = data.main.tempCelsius + "°"
    }
}
