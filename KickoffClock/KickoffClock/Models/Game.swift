 import Foundation

struct ScheduleResponse: Codable {
    let team: Team
    let defaultGameId: Int
    let gameSection: [GameSection]

    enum CodingKeys: String, CodingKey {
        case team = "Team"
        case defaultGameId = "DefaultGameId"
        case gameSection = "GameSection"
    }
}

struct GameSection: Codable {
    let heading: String
    let games: [Game]

    enum CodingKeys: String, CodingKey {
        case heading = "Heading"
        case games = "Game"
    }
}

struct Game: Codable, Identifiable {
    let id: Int
    let week: String?
    let label: String?
    let venue: String?
    let gameState: String?
    let awayScore: String?
    let homeScore: String?
    let isHome: Bool?
    let scheduleHeader: String?
    let type: String?
    let date: GameDate?
    let opponent: Opponent?
    let home: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case week = "Week"
        case label = "Label"
        case venue = "Venue"
        case gameState = "GameState"
        case awayScore = "AwayScore"
        case homeScore = "HomeScore"
        case isHome = "IsHome"
        case scheduleHeader = "ScheduleHeader"
        case type = "Type"
        case date = "Date"
        case opponent = "Opponent"
        case home = "Home"
    }
}

struct GameDate: Codable {
    let numeric: String?
    let text: String?
    let time: String?
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case numeric = "Numeric"
        case text = "Text"
        case time = "Time"
        case timestamp = "Timestamp"
    }
}

struct Opponent: Codable {
    let triCode: String?
    let fullName: String?
    let name: String?
    let city: String?
    let record: String?

    enum CodingKeys: String, CodingKey {
        case triCode = "TriCode"
        case fullName = "FullName"
        case name = "Name"
        case city = "City"
        case record = "Record"
    }
}

struct Team: Codable, Hashable {
    let triCode: String?
    let fullName: String?
    let name: String?
    let city: String?
    let record: String?
    let wins: String?
    let losses: String?
    let winPercentage: String?
    let primaryColor: String?

    enum CodingKeys: String, CodingKey {
        case triCode = "TriCode"
        case fullName = "FullName"
        case name = "Name"
        case city = "City"
        case record = "Record"
        case wins = "Wins"
        case losses = "Losses"
        case winPercentage = "WinPercentage"
        case primaryColor = "PrimaryColor"
    }
}

// MARK: - TeamDisplayable protocol and conformances

protocol TeamDisplayable {
    var nameDisplay: String { get }
    var triCodeDisplay: String? { get }
}

extension Team: TeamDisplayable {
    var nameDisplay: String { fullName ?? name ?? city ?? "" }
    var triCodeDisplay: String? { triCode }
}

extension Opponent: TeamDisplayable {
    var nameDisplay: String { fullName ?? name ?? city ?? "" }
    var triCodeDisplay: String? { triCode }
}