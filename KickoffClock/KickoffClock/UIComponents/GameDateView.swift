import SwiftUI

struct GameDateView: View {
    let dateText: String
    var body: some View {
        Text(dateText)
            .font(.system(size: UIConstants.dateFont))
            .foregroundColor(UIConstants.grayText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, UIConstants.dateLeadingPadding)
            .padding(.top, UIConstants.dateTopPadding)
    }
} 