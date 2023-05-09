//
//  DetailViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 09.05.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var amiiboImage: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    var series: Series!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationLabel.text = series.description
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
