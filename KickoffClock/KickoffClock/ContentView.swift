//
//  ContentView.swift
//  KickoffClock
//
//  Created by Taooufiq El moutaoouakil on 6/17/25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    var body: some View {
        NavigationView {
            scheduleList
                .navigationTitle("SCHEDULE")
                .onAppear {
                    viewModel.fetchSchedule()
                    let appearance = UINavigationBarAppearance.themed(for: viewModel.rootTeam)
                    UINavigationBar.appearance().standardAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                }
        }
    }
    private var scheduleList: some View {
        List {
            ForEach(viewModel.sections, id: \.heading) { section in
                Section(header: SectionHeaderView(title: section.heading)) {
                    ForEach(section.games) { game in
                        if game.type == "B" {
                            ByeRowView()
                        } else {
                            RootTeamGameRowView(game: game, rootTeam: viewModel.rootTeam)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct SectionHeaderView: View {
    let title: String
    var body: some View {
        ZStack {
            UIConstants.sectionHeaderBackground
            Text(title.uppercased())
                .font(.system(size: UIConstants.sectionHeaderFont, weight: .semibold))
                .foregroundColor(UIConstants.sectionHeaderText)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 30)
    }
}

struct ByeRowView: View {
    var body: some View {
        VStack {
            Spacer(minLength: 18)
            Text("BYE")
                .font(.system(size: UIConstants.byeFont, weight: .medium))
                .foregroundColor(UIConstants.byeText)
                .frame(maxWidth: .infinity)
            Text("Week 5")
                .font(.system(size: UIConstants.byeWeekFont, weight: .regular))
                .foregroundColor(UIConstants.byeText)
            Spacer(minLength: 18)
        }
        .frame(height: UIConstants.byeRowHeight)
        .background(UIConstants.whiteBackground)
    }
}

struct RootTeamGameRowView: View {
    let game: Game
    let rootTeam: Team?
    var body: some View {
        if let rootTeam = rootTeam {
            GameRowView(game: game, rootTeam: rootTeam)
        } else {
            EmptyView()
        }
    }
}

struct GameRowView: View {
        let game: Game
        let rootTeam: Team

        var isHome: Bool { game.isHome ?? false }

    var opponentTeam: any TeamDisplayable {
        (game.opponent ?? DummyTeam()) as any TeamDisplayable
    }

    var homeTeam: any TeamDisplayable {
        (isHome ? rootTeam : opponentTeam) as any TeamDisplayable
    }

    var awayTeam: any TeamDisplayable {
        (isHome ? opponentTeam : rootTeam) as any TeamDisplayable
    }

        var homeScore: String { isHome ? (game.homeScore ?? "") : (game.awayScore ?? "") }
        var awayScore: String { isHome ? (game.awayScore ?? "") : (game.homeScore ?? "") }
        var week: String { game.week ?? "" }
        var gameState: String { (game.gameState ?? "").uppercased() }

        var dateText: String {
            if let ts = game.date?.timestamp, let date = ISO8601DateFormatter().date(from: ts) {
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.timeZone = .current
                formatter.setLocalizedDateFormatFromTemplate("EEE, MMM d")
                return formatter.string(from: date)
            }
            return game.date?.text ?? ""
        }

    var homeTriCode: String? { homeTeam.triCodeDisplay }
    var awayTriCode: String? { awayTeam.triCodeDisplay }

        var body: some View {
            VStack(spacing: 0) {
                GameTeamsScoreView(
                    awayTeam: awayTeam,
                    awayScore: awayScore,
                    homeTeam: homeTeam,
                    homeScore: homeScore
                ) {
                    GameCenterContainerView(
                        awayTriCode: awayTriCode,
                        homeTriCode: homeTriCode,
                        week: week
                    )
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                GameDateView(dateText: dateText)
                GameStateView(gameType: game.type, gameState: gameState, time: game.date?.time)
            }
            .background(UIConstants.whiteBackground)
        }
    }


struct GameTeamsScoreView<CenterContent: View>: View {
    let awayTeam: TeamDisplayable
    let awayScore: String
    let homeTeam: TeamDisplayable
    let homeScore: String
    let centerContent: () -> CenterContent
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                TeamNameView(team: awayTeam)
                ScoreView(score: awayScore)
            }
            .frame(width: 80, alignment: .leading)
            Spacer(minLength: UIConstants.rowHorizontalPadding)
            centerContent()
            Spacer(minLength: UIConstants.rowHorizontalPadding)
            VStack(alignment: .trailing, spacing: 2) {
                TeamNameView(team: homeTeam)
                ScoreView(score: homeScore)
            }
            .frame(width: 80, alignment: .trailing)
        }
    }
}

// MARK: - Navigation Bar Styling
extension UINavigationBarAppearance {
    static func themed(for team: Team?) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        if let hex = team?.primaryColor {
            appearance.backgroundColor = UIColor(Color(hex: hex))
        } else {
            appearance.backgroundColor = .systemBackground
        }
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return appearance
    }
}

#Preview {
    ContentView()
}
