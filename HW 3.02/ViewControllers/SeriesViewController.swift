//
//  DetailViewController.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 09.05.2023.
//

import UIKit

final class SeriesViewController: UITableViewController {
    // MARK: - Public properties
    var series: [Series] = []
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let amiibo = series[indexPath.row]
        let detailVC = segue.destination as? DetailViewController
        detailVC?.series = amiibo
    }

    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "amiiboCell", for: indexPath)
        guard let cell = cell as? AmiiboCell else { return UITableViewCell() }
        let series = series[indexPath.row]
        cell.configure(with: series)
        return cell
    }
}
