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

// 5일 간의 일기예보 - 오늘, 화, 수, 목, 금
enum Week: String {
    case mon = "월"
    case tue = "화"
    case wed = "수"
    case thur = "목"
    case fri = "금"
    case sat = "토"
    case sun = "일"
}

final class WeatherTableViewCell: BaseTableViewCell {
    
    private let dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    private let iconImageView = UIImageView()
    
    private let minTempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .systemGray
        $0.textAlignment = .center
    }
    
    private let maxTempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    override func addSubviews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(maxTempLabel)
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
        
        minTempLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }
        
        maxTempLabel.snp.makeConstraints {
            $0.leading.equalTo(minTempLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureCell(data: ForecastOutput.Day?) {
        guard let data else { return }
        dayLabel.text = data.day
        iconImageView.kf.setImage(with: data.iconURL)
        minTempLabel.text = data.tempMin
        maxTempLabel.text = data.tempMax
    }
}
