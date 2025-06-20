import SwiftUI

struct GameCenterContainerView: View {
    let awayTriCode: String?
    let homeTriCode: String?
    let week: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.clear)
                .frame(width: UIConstants.centerContainerWidth, height: UIConstants.centerContainerHeight)
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    TeamLogoView(triCode: awayTriCode)
                        .frame(width: UIConstants.logoSize, height: UIConstants.logoSize)
                    Text("vs")
                        .font(.system(size: UIConstants.vsFont, weight: .medium))
                        .foregroundColor(UIConstants.grayText)
                    TeamLogoView(triCode: homeTriCode)
                        .frame(width: UIConstants.logoSize, height: UIConstants.logoSize)
                }
                if !week.isEmpty {
                    Text(week)
                        .font(.system(size: UIConstants.weekFont))
                        .foregroundColor(UIConstants.grayText)
                        .padding(.top, 4)
                }
            }
            .frame(width: UIConstants.centerContainerWidth, height: UIConstants.centerContainerHeight, alignment: .center)
        }
        .frame(width: UIConstants.centerContainerWidth, height: UIConstants.centerContainerHeight)
    }
} 