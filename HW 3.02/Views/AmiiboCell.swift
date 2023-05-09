//
//  AmiiboCell.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 09.05.2023.
//

import UIKit

class AmiiboCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var gameSeriesLabel: UILabel!
    @IBOutlet weak var amiiboImage: UIImageView!
    
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Configure cell
    func configure(with series: Series) {
        nameLabel.text = series.name
        typeLabel.text = series.type
        gameSeriesLabel.text = series.gameSeries
        
        networkManager.fetchImage(from: series.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.amiiboImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
