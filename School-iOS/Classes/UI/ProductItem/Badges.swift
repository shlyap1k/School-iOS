//
//  Badges.swift
//  School-iOS
//
//  Created by Shlyap1k on 29.11.2023.
//

import SwiftUI

struct Badges: View {
    @Binding var badges: [Badge]
    
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
        Badges(badges: .constant([
            Badge(value: "Хит сезона", color: "#3C72BF"),
            Badge(value: "Hot", color: "#BF3C3C"),
            Badge(value: "Скидка", color: "#3CBF49")
        ])).border(.red)
        Badges(badges: .constant([
            Badge(value: "Хит сезона", color: "#3C72BF"),
            Badge(value: "Скидка", color: "#3CBF49")
        ])
        ).border(.red)
        Badges(badges: .constant([
            Badge(value: "Хит сезона", color: "#3C72BF"),
            Badge(value: "Hot", color: "#BF3C3C")
        ])
        ).border(.red)
        Badges(badges: .constant([
            Badge(value: "Хит сезона", color: "#3C72BF"),
        ])
        ).border(.red)
    }
}
