//
//  LandMark.swift
//  BNZDemoTest
//
//  Created by seven on 2026/1/22.
//

import Foundation

struct LandMark: Codable, Hashable, Identifiable {
    let name: String?
    let category: String?
    let city: String?
    let state: String?
    let id: Int
    let isFeatured: Bool?
    let isFavorite: Bool?
    let park: String?
    let coordinates: Coordinates?
    let description: String?
    let imageName: String?
    
    struct Coordinates: Codable, Hashable {
        let longitude: Double?
        let latitude: Double?
    }
}
