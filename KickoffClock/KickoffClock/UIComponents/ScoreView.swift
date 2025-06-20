import SwiftUI

struct ScoreView: View {
    let score: String
    var body: some View {
        Text(score)
            .font(.system(size: UIConstants.scoreFont, weight: .semibold))
            .foregroundColor(UIConstants.blackText)
    }
} 