//
//  Amiibo.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 05.05.2023.
//

import Foundation

struct Amiibo: Decodable {
    let amiibo: [Series]
}

struct Series: Decodable {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: URL
    let name: String
    let release: Release
    let tail: String
    let type: String
}

struct Release: Decodable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}
