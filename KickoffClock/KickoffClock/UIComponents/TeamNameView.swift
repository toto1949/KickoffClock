import SwiftUI

struct TeamNameView: View {
    let team: TeamDisplayable
    var body: some View {
        Text(team.nameDisplay)
            .font(.system(size: UIConstants.teamNameFont, weight: .bold))
            .foregroundColor(UIConstants.blackText)
            .textCase(.uppercase)
    }
} 