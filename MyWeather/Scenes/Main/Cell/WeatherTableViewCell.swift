//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class WeatherTableViewCell: BaseTableViewCell {
    
    private let dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    private let iconImageView = UIImageView()
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let minTempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .systemGray2
        $0.textAlignment = .center
    }
    
    private let maxTempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    override func addSubviews() {
        stackView.addArrangedSubview(minTempLabel)
        stackView.addArrangedSubview(maxTempLabel)
        contentView.addSubview(dayLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(stackView)
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .clear
    }
    
    func configureCell(data: ForecastOutput.Day?) {
        guard let data else { return }
        dayLabel.text = data.day
        iconImageView.kf.setImage(with: data.iconURL)
        minTempLabel.text = data.tempMin
        maxTempLabel.text = data.tempMax
    }
}
