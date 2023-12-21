//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct ImagesSlider: View {
    var viewModel: ImagesSliderModel = .init()

    var body: some View {
        TabView {
            ForEach(viewModel.images) { imageModel in
                LoadImage(imageUrl: imageModel.url)
                    .frame(width: 200, height: 200)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .tabViewStyle(.page)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .onAppear {
            setupAppearance()
        }
        .frame(height: 244)
    }

    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

#Preview {
    ImagesSlider(viewModel: ImagesSliderModel(images: [
        ImageModel(
            url: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340"
        ),
        ImageModel(
            url: "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D"
        ),
        ImageModel(
            url: "https://.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D"
        ),
    ]))
}
