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

struct Series: Decodable, CustomStringConvertible {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let image: URL
    let name: String
    let release: Release
    let type: String
    
    var description: String {
        """
        Character: \(character)
        
        Game series: \(gameSeries)
        
        Character name: \(name)
        
        Country release:
         Australia: \(release.au ?? "haven't date of release")
         Europe: \(release.eu ?? "haven't date of release")
         Japan : \(release.jp ?? "haven't date of release")
         USA: \(release.na ?? "haven't date of release")
        
        Type: \(type)
        """
    }
}

struct Release: Decodable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}
