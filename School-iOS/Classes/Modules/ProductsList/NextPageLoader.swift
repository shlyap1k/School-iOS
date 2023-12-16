//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct NextPageLoader: View {
    var nextPage: () -> Void

    var body: some View {
        ZStack(alignment: .center) {
            EmptyView()
        }
        .frame(height: 50)
        .onAppear {
            nextPage()
        }
    }
}

#Preview {
    NextPageLoader(nextPage: {})
}
