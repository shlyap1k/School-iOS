//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct CheckoutForm: View {
    @StateObject var viewModel: CheckoutFormVM = .init()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text(L10n.CartCheckout.products)
                        .applyStyle(.bold16)
                    ProductsInCart(products: viewModel.orderCheckout)

                    Text(L10n.CartCheckout.deliveryDetails)
                        .applyStyle(.bold16)

                    Text(L10n.CartCheckout.address)
                    InputField(title: "", model: $viewModel.house)

                    Text(L10n.CartCheckout.apartment)
                    InputField(title: "", model: $viewModel.apartment)

                    Text(L10n.CartCheckout.deliveryDate)
                    DatePicker(selection: $viewModel.deliveryDate) {
                        Color.red
                    }
                    .accentColor(.red)
                    .datePickerStyle(.graphical)
                }
                .padding(.bottom, 56 + 16)
            }
            .scrollIndicators(.hidden)
            StyledButton(isLoading: $viewModel.isLoading, title: L10n.CartCheckout.checkout, style: .blue) {
                viewModel.checkout {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            viewModel.loadCart()
        }
        .padding(16)
        .navigationTitle(L10n.CartCheckout.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CheckoutForm()
    }
}
