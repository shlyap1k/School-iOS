//
//  CountSelector.swift
//  School-iOS
//
//  Created by Shlyap1k on 10.12.2023.
//

import SwiftUI

struct CountSelector: View {
    @ObservedObject var viewModel: CountSelectorModel
    
    let style: CountSelectorStyle
    var body: some View {
        
        ZStack {
            Rectangle()
                .cornerRadius(8)
                .backgroundStyle(style.backgroundColor)
                .frame(height: style.height)
            
            HStack(spacing: 0) {
                Button(action: { viewModel.decrease() }) {
                    Text("-")
                        .applyStyle(.regular18)
                        .frame(width: 44, height: style.height)
                        .padding(.leading, 5)
                }.disabled(!viewModel.desreaseEnabled)
                
                Text("\(viewModel.count)")
                    .applyStyle(.regular18)
                    .lineLimit(1)
                    .layoutPriority(100)
                    .frame(width: 52)
                
                Button(action: { viewModel.increase() }) {
                    Text("+")
                        .applyStyle(.regular18)
                        .frame(width: 44, height: style.height)
                        .padding(.trailing, 5)
                }
                
            }
            .foregroundColor(.white)
            
        }
        .frame(width: 148)
    }
}

#Preview {
    HStack {
        CountSelector(viewModel: CountSelectorModel(), style: .big)
        CountSelector(viewModel: CountSelectorModel(), style: .small)
    }
}
