//
//  ScheduleService.swift
//  KickoffClock
//
//  Created by Taooufiq El moutaoouakil on 6/17/25.
//

import Foundation

protocol ScheduleServiceProtocol {
    func fetchSchedule() async throws -> ScheduleResponse
}

class ScheduleService: ScheduleServiceProtocol {
    static let shared = ScheduleService()
    private let urlString = AppURLs.scheduleJSON

    func fetchSchedule() async throws -> ScheduleResponse {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(ScheduleResponse.self, from: data)
    }
} 