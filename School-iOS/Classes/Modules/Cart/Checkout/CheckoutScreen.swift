//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - FocusedField

private enum FocusedField: Hashable {
    case address, apartment
}

// MARK: - CheckoutScreen

struct CheckoutScreen: View {
    // MARK: Internal

    @StateObject var viewModel: CheckoutVM = .init()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.CartCheckout.products)
                            .applyStyle(.bold16)
                        ProductsInCart(products: viewModel.orderCheckout)

                        Text(L10n.CartCheckout.deliveryDetails)
                            .applyStyle(.bold16)

                        Text(L10n.CartCheckout.address)
                        InputField(title: "", model: $viewModel.houseModel)
                            .focused($isFocused, equals: .address)

                        Text(L10n.CartCheckout.apartment)
                        InputField(title: "", model: $viewModel.apartmentModel)
                            .focused($isFocused, equals: .apartment)

                        Text(L10n.CartCheckout.deliveryDate)
                    }
                    .onTapGesture {
                        isFocused = nil
                    }

                    DatePicker(
                        selection: $viewModel.deliveryDate,
                        in: Date.now...
                    ) {
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

    // MARK: Private

    @FocusState private var isFocused: FocusedField?
}

#Preview {
    NavigationStack {
        CheckoutScreen()
    }
}
