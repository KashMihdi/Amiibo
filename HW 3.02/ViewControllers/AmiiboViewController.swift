//
//  ViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 05.05.2023.
//

import UIKit

final class AmiiboViewController: UIViewController {
    
    @IBOutlet weak var amiiboPicker: UIPickerView!
    
    private let networkManager = NetworkManager.shared
    private var amiiboList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amiiboPicker.delegate = self
        amiiboPicker.dataSource = self
        fetchAmiibo()
    }
    
    private func fetchAmiibo() {
        networkManager.fetch(Amiibo.self, from: Link.amiiboURL.url) { [weak self] result in
            switch result {
            case .success(let amiibo):
                let dictionaryOfAmiibo = Dictionary(
                    grouping: amiibo.amiibo,
                    by: { $0.amiiboSeries }
                )
                let series = Array(dictionaryOfAmiibo.keys).sorted()
                self?.amiiboList = series
                DispatchQueue.main.async {
                    self?.amiiboPicker.reloadAllComponents()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AmiiboViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        amiiboList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        amiiboList[row]
    }
    
}
