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
    private var amiiboList: [String : [Series]] = [:]
    private lazy var selectedSeries: String = amiiboList.keys.first ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amiiboPicker.delegate = self
        amiiboPicker.dataSource = self
        fetchAmiibo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? SeriesViewController else { return }
        detailVC.series = amiiboList[selectedSeries] ?? [Series]()
    }
    
    private func fetchAmiibo() {
        networkManager.fetch(Amiibo.self, from: Link.amiiboURL.url) { [weak self] result in
            switch result {
            case .success(let amiibo):
                let dictionaryOfAmiibo = Dictionary(
                    grouping: amiibo.amiibo,
                    by: { $0.amiiboSeries }
                )
                DispatchQueue.main.async {
                    self?.amiiboList = dictionaryOfAmiibo
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
        amiiboList.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let series = Array(amiiboList.keys).sorted()
        return series[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSeries = Array(amiiboList.keys).sorted()[row]
        print(selectedSeries)
    }
    
}
