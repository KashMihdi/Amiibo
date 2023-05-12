//
//  Amiibo.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 05.05.2023.
//

import Foundation

struct Amiibo: Decodable {
    let amiibo: [Series]
    
    init(amiibo: [Series]) {
        self.amiibo = amiibo
    }
    
    init(from data: [String: Any]) {
            guard let amiiboData = data["amiibo"] as? [[String: Any]] else {
                    amiibo = []
                    return
            }
            amiibo = amiiboData.map { Series(from: $0) }
        }
    
    static func getAmiibo(from value: Any) -> Amiibo {
        guard let amiiboData = value as? [String : Any] else { return Amiibo(amiibo: []) }
        return Amiibo(from: amiiboData)
    }
}

struct Series: Decodable, CustomStringConvertible {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let image: String
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
    
    init(from seriesData: [String : Any]) {
        amiiboSeries = seriesData["amiiboSeries"] as? String ?? ""
        character = seriesData["character"] as? String ?? ""
        gameSeries = seriesData["gameSeries"] as? String ?? ""
        image = seriesData["image"] as? String ?? ""
        name = seriesData["name"] as? String ?? ""
        release = Release(from: seriesData["release"] as? [String: Any] ?? [:])
        type = seriesData["type"] as? String ?? ""
    }
}

struct Release: Decodable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
    
    init(au: String?, eu: String?, jp: String?, na: String?) {
        self.au = au
        self.eu = eu
        self.jp = jp
        self.na = na
    }
    
    init(from releaseData: [String : Any]) {
        au = releaseData["au"] as? String
        eu = releaseData["eu"] as? String
        jp = releaseData["jp"] as? String
        na = releaseData["na"] as? String
    }
}
