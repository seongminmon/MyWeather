//
//  WeatherCollectionViewCell.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit
import SnapKit
import Then

class WeatherCollectionViewCell: BaseCollectionViewCell {
    
    let mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 4
    }
    
    let hourLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let tempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    override func addSubviews() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(hourLabel)
        mainStackView.addArrangedSubview(iconImageView)
        mainStackView.addArrangedSubview(tempLabel)
    }
    
    override func configureLayout() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hourLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        tempLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
    }
    
    override func configureView() {
        
    }
    
    func configureCell(hour: String, image: UIImage, temp: String) {
        hourLabel.text = hour
        iconImageView.image = image
        tempLabel.text = temp
    }
}
