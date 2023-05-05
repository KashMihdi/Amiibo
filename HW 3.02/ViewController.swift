//
//  ViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 05.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let url = URL(string: "https://www.amiiboapi.com/api/amiibo/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAmiibo()
    }
    
    private func fetchAmiibo() {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                let amiiboInfo = try decoder.decode(Amiibo.self, from: data)
                for amiibo in amiiboInfo.amiibo {
                    print ("\(amiibo)\n")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

