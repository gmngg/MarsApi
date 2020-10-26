//
//  CamerasView.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 22.10.2020.
//

import UIKit

class CamerasViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.getModel()
        }
        view.backgroundColor = .orange
        setupView()
        setupCollectionView()
    }
    
    var collectionView: UICollectionView!
    
    var viewModel: CamerasViewModelInterfase
    
    func updateView() {
        viewModel.updateView = {
            self.collectionView.reloadData()
        }
    }
    
    func setupView() {
        title = viewModel.roverName
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(CamerasCollectionViewCell.self, forCellWithReuseIdentifier: CamerasCollectionViewCell.reuseId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let cSection = self.viewModel.photoItem else {
                return self.createLayoutSection()
            }
            let section = Array(cSection.dictionary)[sectionIndex]
            switch section.key {
            default:
                return self.createLayoutSection()
            }
        }
        return layout
    }
    
    func createLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
    
    required init(container: Container) {
        viewModel = container.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CamerasViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        guard let countSection = viewModel.photoItem?.dictionary.count else {
            return 1
        }
        return countSection
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cSection = viewModel.photoItem else {
            return 1
        }
        return Array(cSection.dictionary)[section].value.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cSection = viewModel.photoItem else {
            return CamerasCollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CamerasCollectionViewCell.reuseId,
                for: indexPath) as! CamerasCollectionViewCell
        let section = Array(cSection.dictionary)[indexPath.section]
        let item = section.value[indexPath.item]
        cell.configure(text: item.dataPhoto ?? "", image: item.imageURL ?? "")
        
        return cell
    }
}

extension CamerasViewController: Injectable {
    struct Container {
        let viewModel: CamerasViewModelInterfase
    }
}
