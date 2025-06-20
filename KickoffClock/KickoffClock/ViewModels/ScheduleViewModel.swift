//
//  ScheduleViewModel.swift
//  KickoffClock
//
//  Created by Taooufiq El moutaoouakil on 6/17/25.
//

import Foundation
import Combine

class ScheduleViewModel: ObservableObject {
    @Published var sections: [GameSection] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var rootTeam: Team? = nil

    private var cancellables = Set<AnyCancellable>()
    private let service: ScheduleServiceProtocol

    init(service: ScheduleServiceProtocol = ScheduleService.shared) {
        self.service = service
    }

    func fetchSchedule() {
        isLoading = true
        errorMessage = nil
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let response = try await self.service.fetchSchedule()
                DispatchQueue.main.async {
                    self.sections = response.gameSection
                    self.rootTeam = response.team
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
} 