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
        guard let amiiboData = value as? [String : Any] else {
            return Amiibo(amiibo: [])
        }
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
         Australia: \(release.australia ?? "haven't date of release")
         Europe: \(release.europe ?? "haven't date of release")
         Japan : \(release.japan ?? "haven't date of release")
         USA: \(release.usa ?? "haven't date of release")
        
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
    let australia: String?
    let europe: String?
    let japan: String?
    let usa: String?

    init(from releaseData: [String : Any]) {
        australia = releaseData["au"] as? String
        europe = releaseData["eu"] as? String
        japan = releaseData["jp"] as? String
        usa = releaseData["na"] as? String
    }
}
