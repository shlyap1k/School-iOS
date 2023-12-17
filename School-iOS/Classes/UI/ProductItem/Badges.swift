//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - Badges

struct Badges: View {
    // MARK: Internal

    var badges: [Badge]

    var body: some View {
        VStack {
            GeometryReader { geometry in
                generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    // MARK: Private

    @State private var totalHeight
        = CGFloat.zero

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(badges, id: \.self) { badge in
                item(for: badge.value, badge.color)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > g.size.width {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if badge == badges.last! {
                            width = 0 // last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if badge == badges.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String, _ color: String) -> some View {
        Text(text)
            .applyStyle(.bold12)
            .foregroundColor(.white)
            .padding([.leading, .trailing], 22)
            .padding([.top, .bottom], 2)
            .background(
                Rectangle()
                    .foregroundColor(Color(hex: color))
                    .cornerRadius(8)
            )
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    VStack {
        Badges(badges: [
            Badge(value: "Хит сезона", color: "#3C72BF"),
            Badge(value: "Hot", color: "#BF3C3C"),
            Badge(value: "Скидка", color: "#3CBF49"),
        ])
        .border(.red)
        Badges(
            badges: [
                Badge(value: "Хит сезона", color: "#3C72BF"),
                Badge(value: "Скидка", color: "#3CBF49"),
            ]
        ).border(.red)
        Badges(
            badges: [
                Badge(value: "Хит сезона", color: "#3C72BF"),
                Badge(value: "Hot", color: "#BF3C3C"),
            ]
        ).border(.red)
        Badges(
            badges: [
                Badge(value: "Хит сезона", color: "#3C72BF"),
            ]
        ).border(.red)
    }
}

private extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
