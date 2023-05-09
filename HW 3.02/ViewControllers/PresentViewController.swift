//
//  PresentViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 09.05.2023.
//

import UIKit

class PresentViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private property
    private let networkManager = NetworkManager.shared
    
    // MARK: - ViewLifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAmiibo()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let amiiboVC = navigationVC.topViewController as? AmiiboViewController else { return }
        amiiboVC.amiiboList = sender as? [String : [Series]] ?? [:]
    }
}

// MARK: - Networking
extension PresentViewController {
    private func fetchAmiibo() {
        networkManager.fetch(from: Link.amiiboURL.url) { [weak self] result in
            switch result {
            case .success(let amiibo):
                let dictionaryOfAmiibo = Dictionary(
                    grouping: amiibo.amiibo,
                    by: { $0.amiiboSeries }
                )
                DispatchQueue.main.async {
                    self?.performSegue(
                        withIdentifier: "showAmiibo",
                        sender: dictionaryOfAmiibo
                    )
                    self?.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
