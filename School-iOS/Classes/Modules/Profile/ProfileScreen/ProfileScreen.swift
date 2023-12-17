//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct ProfileScreen: View {
    // MARK: Internal

    @StateObject var viewModel: ProfileVM = .init()

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                CircularUserImage(imageState: viewModel.userImage.imageState)
                    .isLoading($viewModel.isLoading, .constant(true))
                    .padding(.top, 4)
                    .padding(.bottom, 26)

                Text("\(viewModel.profile.name) \(viewModel.profile.surname)")
                    .applyStyle(.bold18)
                    .padding(.bottom, 4)
                    .foregroundStyle(.white)
                Text(viewModel.profile.occupation)
                    .padding(.bottom, 16)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .background(
                Color(.backgroundBlack)
                    .cornerRadius(8)
                    .ignoresSafeArea()
            )
            VStack {
                NavigationLink(value: ProfileRoutes.ordersList) {
                    MenuItem(title: L10n.Profile.Menu.ordersList, action: {})
                        .allowsHitTesting(false)
                }
                .overlay(alignment: .bottom) {
                    Divider()
                }
                MenuItem(title: L10n.Profile.Menu.logout, action: { isPresented.toggle() })
            }.padding([.leading, .trailing], 16)
            Spacer()
        }
        .navigationDestination(for: ProfileRoutes.self, destination: { route in
            switch route {
            case .ordersList:
                OrdersListScreen()
            case .profileEdit:
                ProfileEditScreen(userImage: viewModel.userImage)
            }
        })
        .onAppear {
            viewModel.fetchProfile()
        }
        .toolbar {
            NavigationLink(value: ProfileRoutes.profileEdit) {
                Button(action: {}) {
                    Image(.pencil).resizable()
                        .frame(width: 22, height: 22)
                }
                .allowsHitTesting(false)
            }
        }
        .confirmationDialog("", isPresented: $isPresented, actions: {
            Button(L10n.Profile.Logout.action, role: .destructive) {
                viewModel.logout()
            }
            Button(L10n.Profile.Logout.cancel, role: .cancel) {
                isPresented = false
            }
        }, message: {
            Text(L10n.Profile.Logout.title)
        })
    }

    // MARK: Private

    @State private var isPresented: Bool = false
}

#Preview {
    NavigationStack {
        ProfileScreen()
    }
}
