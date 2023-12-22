//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct ProfileEditScreen: View {
    @StateObject var viewModel: ProfileEditVM = .init()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var userImage: UserImageModel = .init()

    var body: some View {
        VStack(spacing: 0) {
            EditableCircularUserImage(model: viewModel.userImage)
                .padding(.top, 4)
                .padding(.bottom, 20)

            if let error = viewModel.imageError {
                Text(error)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(L10n.Profile.Edit.name)
                InputField(title: L10n.Profile.Edit.name, model: $viewModel.nameModel)
                    .padding(.bottom, 4)

                Text(L10n.Profile.Edit.surname)
                InputField(title: L10n.Profile.Edit.surname, model: $viewModel.surnameModel)
                    .padding(.bottom, 4)

                Text(L10n.Profile.Edit.occupation)
                InputField(title: L10n.Profile.Edit.occupation, model: $viewModel.occupationModel)
            }

            Spacer()

            if viewModel.isSaved {
                Rectangle()
                    .hidden()
                    .onAppear {
                        presentationMode.wrappedValue.dismiss()
                    }
            }

            StyledButton(isLoading: $viewModel.isLoading, title: L10n.Profile.Edit.action, style: .blue, action: {
                viewModel.saveProfileChanges()
            })
        }
        .padding(16)
        .navigationTitle(L10n.Profile.Edit.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.setImage(image: userImage)
            viewModel.loadProfile()
        }
    }
}

#Preview {
    NavigationStack {
        ProfileEditScreen(userImage: .init())
    }
}
