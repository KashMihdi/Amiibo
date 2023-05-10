//
//  DetailViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 09.05.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var amiiboImage: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public properties
    var series: Series!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        informationLabel.text = series.description
        fetchImage()
    }
}

// MARK: - Networking
extension DetailViewController {
    private func fetchImage() {
        networkManager.fetchImage(from: series.image) { result in
            switch result {
            case .success(let imageData):
                self.amiiboImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
