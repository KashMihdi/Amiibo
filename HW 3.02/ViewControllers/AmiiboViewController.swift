//
//  ViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 05.05.2023.
//

import UIKit

final class AmiiboViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAmiibo()
    }
    
    private func fetchAmiibo() {
        let url = URL(string: "https://www.amiiboapi.com/api/amiibo/")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                let amiiboInfo = try decoder.decode(Amiibo.self, from: data)
                for index in 0...2 {
                    print("\(amiiboInfo.amiibo[index].description)\n")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

