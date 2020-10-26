//
//  File.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 26.10.2020.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseId = "sectionHeader"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func cunstomizeElements() {
        title.textColor = .black
        title.font = .systemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
