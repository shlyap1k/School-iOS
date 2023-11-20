//
//  UserImageModel.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import CoreTransferable
import Foundation
import PhotosUI
import SwiftUI

class UserImageModel: ObservableObject {
    // MARK: Internal

    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }

    enum TransferError: Error {
        case importFailed
    }

    struct ProfileImage: Transferable {
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                #if canImport(AppKit)
                    guard let nsImage = NSImage(data: data) else {
                        throw TransferError.importFailed
                    }
                    let image = Image(nsImage: nsImage)
                    return ProfileImage(image: image)
                #elseif canImport(UIKit)
                    guard let uiImage = UIImage(data: data) else {
                        throw TransferError.importFailed
                    }
                    let image = Image(uiImage: uiImage)
                    return ProfileImage(image: image)
                #else
                    throw TransferError.importFailed
                #endif
            }
        }

        let image: Image
    }

    @Published private(set) var imageState: ImageState = .empty

    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }

    // MARK: - Private Methods

    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case let .success(profileImage?):
                    self.imageState = .success(profileImage.image)
                case .success(nil):
                    self.imageState = .empty
                case let .failure(error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
