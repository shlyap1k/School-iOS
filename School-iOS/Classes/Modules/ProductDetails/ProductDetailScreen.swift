//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - ProductDetailScreen

struct ProductDetailScreen: View {
    @Binding var tabSelection: TabBarRoutes

    @StateObject var viewModel: ProductDetailVM

    @State var title: String = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ImagesSlider(viewModel: viewModel.imagesSliderModel)

                    SizeSelector(selectorModel: viewModel.sizeSelectorModel)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 16)

                    Text(viewModel.product.title)
                        .padding([.leading, .bottom], 16)
                        .applyStyle(.bold16)

                    Text(viewModel.product.description)
                        .padding([.leading, .trailing], 16)

                    Text(L10n.ProductDetails.specs)
                        .applyStyle(.bold16)
                        .padding([.top, .leading], 16)
                        .padding(.bottom, 6)
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.product.details, id: \.self) { detail in
                            Text(detail)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 16)
                        }
                    }
                }.padding(.bottom, 32 + 56)
                    .background(GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                    })
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        if value.y <= -1 {
                            title = viewModel.product.title
                        } else {
                            title = ""
                        }
                    }
            }
            .scrollIndicators(.hidden)

            if !viewModel.showGoToCart {
                StyledButton(title: L10n.ProductDetails.buy, style: .blue, action: {
                    if viewModel.sizeSelectorModel.selectedSize != nil {
                        viewModel.showGoToCart.toggle()
                        viewModel.addToCart()
                        if viewModel.showError {
                            viewModel.showError.toggle()
                        }
                    } else {
                        viewModel.showError.toggle()
                    }
                })
                .padding(16)
            } else {
                HStack(spacing: 8) {
                    StyledButton(title: L10n.ProductDetails.cart, style: .green, action: {
                        viewModel.goToCart(tabSelection: &tabSelection)
                        viewModel.saveCount()
                        viewModel.reset()
                    })

                    CountSelector(count: $viewModel.count, style: .big)
                }
                .padding(16)
            }
        }
        .coordinateSpace(name: "scroll")
        .navigationTitle(
            viewModel.showError ? L10n.ProductDetails.buyError : title
        )
        .navigationBarBackground(
            background: viewModel.showError ? Assets.red.swiftUIColor : Assets.white.swiftUIColor,
            fontColor: viewModel.showError ? ColorScheme.dark : ColorScheme.light
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - ScrollOffsetPreferenceKey

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value _: inout CGPoint, nextValue _: () -> CGPoint) {}
}

#Preview {
    ProductDetailScreen(
        tabSelection: .constant(.catalog), viewModel:
        ProductDetailVM(
            product: Product(
                id: "aboba",
                title: "Men's ",
                department: "Джерси",
                price: 9000,
                badge: [
                    Badge(value: "Хит сезона", color: "#3C72BF"),
                    Badge(value: "Hot", color: "#BF3C3C"),
                    Badge(value: "Скидка", color: "#3CBF49"),
                ],
                preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                images: [
                    "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                    "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
                ],
                sizes: [
                    Size(value: "M", isAvailable: true),
                    Size(value: "L", isAvailable: true),
                    Size(value: "XL", isAvailable: true),
                    Size(value: "XS", isAvailable: false),
                ],
                description: "description: ",
                details: [
                    "Material: 100% Polyester",
                    "Foam tongue helps reduce lace pressure.",
                    "Mesh in the upper provides a breathable and plush sensation that stretches with your foot.",
                    "Midfoot webbing delivers security. The webbing tightens around your foot when you lace up, letting you choose your fit and feel.",
                    "Nike React foam is lightweight, springy and durable. More foam means better cushioning without the bulk. A Zoom Air unit in the forefoot delivers more bounce with every step. It's top-loaded to be closer to your foot for responsiveness.",
                    "The classic fit and feel of the Pegasus is back—with a wider toe box to provide extra room. Seaming on the upper provides a better shape and fit, delivering a fresh take on an icon.",
                    "Officially licensed",
                    "Imported",
                    "Brand: Nike",
                ]
            )
        )
    )
}
