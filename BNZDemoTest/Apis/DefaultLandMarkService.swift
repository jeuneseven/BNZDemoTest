//
//  DefaultLandMarkService.swift
//  BNZDemoTest
//
//  Created by seven on 2026/1/22.
//

import Foundation

struct DefaultLandMarkService: LandMarkService {
    func fetch<T: Decodable>(from urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invaliedURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Log response for debugging (remove in production)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON:\n\(jsonString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invaliedResponse
            }
            
            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    func fetchList() async throws -> [LandMark] {
        let url = "https://raw.githubusercontent.com/ThrownToys/landmarkdata/refs/heads/main/landmarkData.json"
        return try await fetch(from: url, type: [LandMark].self)
    }
}
