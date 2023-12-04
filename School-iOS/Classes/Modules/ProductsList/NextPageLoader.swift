//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct NextPageLoader: View {
    @ObservedObject var viewModel: ProductsListVM

    var body: some View {
        ZStack(alignment: .center) {
            if viewModel.isLoading {
                LoaderView()
            } else {
                EmptyView()
            }
        }
        .frame(height: 50)
        .onAppear {
            viewModel.nextPage()
        }
    }
}

#Preview {
    NextPageLoader(viewModel: ProductsListVM())
}
