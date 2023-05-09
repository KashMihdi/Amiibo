//
//  ViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 05.05.2023.
//

import UIKit

final class AmiiboViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var amiiboPicker: UIPickerView!
    
    // MARK: - Private property
    private lazy var selectedSeries: String = Array(amiiboList.keys).sorted()[0]
    
    // MARK: - Public property
    var amiiboList: [String : [Series]] = [:]
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        amiiboPicker.delegate = self
        amiiboPicker.dataSource = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? SeriesViewController else { return }
        detailVC.series = amiiboList[selectedSeries] ?? [Series]()
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
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
