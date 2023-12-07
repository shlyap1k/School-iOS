//
//  ProductDetailScreen.swift
//  School-iOS
//
//  Created by Shlyap1k on 07.12.2023.
//

import SwiftUI

struct ProductDetailScreen: View {
    var viewModel: Product?
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let imageUrl = viewModel?.images[0] {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                            .frame(width: 200, height: 197)
                            .padding(.bottom, 51)
                    } placeholder: {
                        LoaderView()
                    }
                }
                Text("Размер")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 7)
                    .applyStyle(.bold14)
                HStack(spacing: 8) {
                    if let sizes = viewModel?.sizes {
                        ForEach(sizes, id: \.self) { size in
                            Text(size.value)
                                .padding()
                                .background(
                                    Rectangle()
                                        .foregroundColor(.backgroundGray)
                                        .cornerRadius(8)
                                        .frame(width: 44, height: 44)
                                )
                        }
                    }
                }
                .applyStyle(.bold14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .bottom], 16)
                
                if let title = viewModel?.title {
                    Text(title)
                        .padding(.bottom, 16)
                        .applyStyle(.bold16)
                }
                if let description = viewModel?.description {
                    Text(description)
                        .padding([.leading, .trailing], 16)
                }
                
                if let details = viewModel?.details {
                    Text("Характеристики")
                        .applyStyle(.bold16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading], 16)
                        .padding(.bottom, 6)
                    VStack(spacing: 8) {
                        ForEach(details, id: \.self) { detail in
                            Text(detail)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProductDetailScreen(viewModel: Product(
        id: "aboba",
        title: "Men's Nike J.J. Watt Black Arizona Cardinals Legend Jersey",
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
        ],
        sizes: [
            Size(value: "M", isAvailable: true),
            Size(value: "L", isAvailable: true),
            Size(value: "XL", isAvailable: true),
            Size(value: "XS", isAvailable: false),
        ],
        description: "description: We want fans to celebrate their fandom by customizing and personalizing certain products. For these customizable products, including jerseys, we invite customers to tell us how they would like their preferred name or other text to appear by typing that text into the field indicated. However, just because a customer is able to type proposed customization text into the field and is able to complete the order through the website, not all proposed customization text will be accepted. Please note, Fanatics may reject and cancel any customization order for any reason, including for messages that are deemed offensive or inappropriate. Take your Arizona Cardinals fandom to the next level when you grab this Custom Game Jersey. This Nike gear is perfect for an avid Arizona Cardinals fan like you who never misses a moment of the action. The crisp graphics will put your unwavering pride on full display and ensure everyone knows who you're rooting for at the next game!",
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

//                id: "061f02a0-8d12-4828-ab33-6b319a367e66"
    ))
}
