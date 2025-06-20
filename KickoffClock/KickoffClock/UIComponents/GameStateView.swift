import SwiftUI

struct GameStateView: View {
    let gameType: String?
    let gameState: String
    let time: String?
    var body: some View {
        Group {
            if gameType == "F" {
                Text(gameState)
                    .font(.system(size: UIConstants.finalFont, weight: .semibold))
                    .foregroundColor(UIConstants.blackText)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, UIConstants.finalTrailingPadding)
                    .padding(.bottom, UIConstants.finalBottomPadding)
            } else if gameType == "S", let time = time {
                Text(time)
                    .font(.system(size: UIConstants.finalFont, weight: .semibold))
                    .foregroundColor(UIConstants.grayText)
                    .padding(.trailing, 8)
            }
        }
    }
} 