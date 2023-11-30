//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - Badges

struct Badges: View {
    var badges: [Badge]

    var body: some View {
        HStack(alignment: .top) {
            Grid(alignment: .leading) {
                ForEach(badges.indices.filter { $0 % 2 == 0 }, id: \.self) { index in
                    let badges = Array(
                        badges[index ..< min(index + 2, badges.count)]
                    )
                    GridRow {
                        ForEach(badges) { b in
                            Text(b.value)
                                .applyStyle(.bold12)
                                .foregroundColor(.white)
                                .padding([.leading, .trailing], 22)
                                .padding([.top, .bottom], 2)
                                .background(
                                    Rectangle()
                                        .foregroundColor(Color(hex: b.color))
                                        .cornerRadius(8)
                                )
                                .lineLimit(1)
                                .frame(alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        Badges(badges: [
            Badge(value: "Хит сезона", color: "#3C72BF"),
            Badge(value: "Hot", color: "#BF3C3C"),
            Badge(value: "Скидка", color: "#3CBF49"),
        ]).border(.red)
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
