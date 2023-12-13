//
// HH School
// Created by Shlyap1k.
//

import Combine
import SwiftUI

// MARK: - CartScreen

struct CartScreen: View {
    @ObservedObject var viewModel: CartVM = .init()

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ForEach($viewModel.cart.products, id: \.id) { $product in
                    CartItem(product: $product, removal: viewModel.removeProduct)
                        .onReceive(Just(product), perform: { product in
                            viewModel.saveChanges(product: product)

                        })
                        .overlay(alignment: .bottom) {
                            if product.id != viewModel.cart.products.last?.id {
                                Divider()
                                    .padding([.leading, .trailing], 16)
                            }
                        }
                }
            }
            if !viewModel.cart.products.isEmpty {
                NavigationLink(value: CartRoutes.checkout) {
                    StyledButton(title: L10n.Cart.checkout, style: .blue, action: {})
                        .allowsHitTesting(false)
                        .padding(16)
                }
            }
        }
        .placeholder(viewModel.cart.products.isEmpty ? .emptyCart() : nil)
        .onAppear {
            viewModel.loadIsComplited()
            viewModel.loadCart()
//            setupAppearance()
        }
        .onDisappear {
            viewModel.unsetCheckoutCompleted()
        }
        .navigationDestination(for: CartRoutes.self, destination: { route in
            switch route {
            case .checkout:
                CheckoutForm()
            case .cart:
                CartScreen()
            }
        })
        .navigationTitle((viewModel.isCompleted ?? false) ? L10n.Cart.success : L10n.Cart.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !viewModel.cart.products.isEmpty {
                    Button(action: {
                        viewModel.clearCart()
                    }) {
                        Image(.delete)
                    }
                }
            }
        }
    }

//    func setupAppearance() {
//        guard let isCompleted = viewModel.isCompleted else {
//            return
//        }
//        var color = UIColor(asset: Assets.white)
//        if isCompleted {
//            color = UIColor(asset: Assets.blackSuccess)
//        }
//
//        let coloredAppearance = UINavigationBarAppearance()
//        coloredAppearance.configureWithOpaqueBackground()
//        coloredAppearance.backgroundColor = color
//        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//        viewModel.cart.apartment = "a"
//    }
}

#Preview {
    NavigationStack {
        CartScreen(viewModel: CartVM())
    }
}
