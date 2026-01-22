//
//  LandMarkService.swift
//  BNZDemoTest
//
//  Created by seven on 2026/1/22.
//

import Foundation

protocol LandMarkService: Sendable {
    func fetchList() async throws -> [LandMark]
}
