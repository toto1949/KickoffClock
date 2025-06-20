import Foundation

struct AppURLs {
    static let scheduleJSON = "http://files.yinzcam.com/iOS/interviews/ScheduleExercise/schedule.json"
    static func teamLogoURL(for triCode: String) -> String {
        return "https://resources-us.yinzcam.com/nfl/logos/nfl_\(triCode.lowercased())_light.png"
    }
} 