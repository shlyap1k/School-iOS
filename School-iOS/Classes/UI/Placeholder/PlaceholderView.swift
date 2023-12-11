//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct PlaceholderView: View {
    let model: PlaceholderModel

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            model.image
                .resizable()
                .frame(width: 110, height: 100)
            Text(model.text)
                .applyStyle(.semibold18)
                .foregroundStyle(.black)
            if let action = model.action {
                StyledButton(isLoading: model.isLoading, title: L10n.Placeholder.refresh, style: .blueSmall) {
                    action()
                }
                .frame(width: 120)
            }
        }
    }
}

#Preview {
    PlaceholderView(
        model: .init(
            image: Image(systemName: "network"),
            text: "Title"
        ) {}
    )
}
