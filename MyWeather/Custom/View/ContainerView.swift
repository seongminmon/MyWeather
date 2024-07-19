//
//  ContainerView.swift
//  MyWeather
//
//  Created by 김성민 on 7/13/24.
//

import UIKit
import SnapKit
import Then

final class ContainerView: BaseView {
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let headerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = .white
    }
    
    override func addSubviews() {
        addSubview(visualEffectView)
        addSubview(headerLabel)
        addSubview(separator)
    }
    
    override func configureLayout() {
        visualEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(1)
        }
    }
    
    override func configureView() {
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func configureLabel(imageName: String, text: String) {
        let attributeString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)?.withTintColor(.white)
        attributeString.append(NSAttributedString(attachment: imageAttachment))
        attributeString.append(NSAttributedString(string: text))
        headerLabel.attributedText = attributeString
    }
    
}
