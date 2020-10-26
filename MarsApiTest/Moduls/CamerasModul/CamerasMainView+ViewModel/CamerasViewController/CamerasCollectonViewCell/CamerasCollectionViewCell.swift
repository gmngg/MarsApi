//
//  CamerasCollectionViewCell.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import UIKit

class CamerasCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "camerasPhoto"
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageViewPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var dataPhoto: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    func createImage(url: String) {
        let imageError = UIImage(named: "ErrorImage")
        guard let url = URL(string: url) else {
            self.imageViewPhoto.image = imageError
            return
        }
        DispatchQueue.main.async {
            guard let data = try? Data(contentsOf: url) else {
                self.imageViewPhoto.image = imageError
                return
            }
            self.imageViewPhoto.image = UIImage(data: data)
            
        }
    }
    
    func configure(text: String, image: String) {
        dataPhoto.text = text
        createImage(url: image)
    }
    
    func setupView() {
        addSubview(imageViewPhoto)
        addSubview(dataPhoto)
        
        imageViewPhoto.translatesAutoresizingMaskIntoConstraints = false
        dataPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewPhoto.heightAnchor.constraint(equalToConstant: 138),
            imageViewPhoto.widthAnchor.constraint(equalToConstant: 76),
            imageViewPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageViewPhoto.topAnchor.constraint(equalTo: self.topAnchor),
            dataPhoto.topAnchor.constraint(equalTo: imageViewPhoto.bottomAnchor),
            dataPhoto.leadingAnchor.constraint(equalTo: imageViewPhoto.leadingAnchor)
        ])
    }
}
