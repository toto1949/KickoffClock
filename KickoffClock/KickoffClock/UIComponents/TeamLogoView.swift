import SwiftUI


struct TeamLogoView: View {
    let triCode: String?
    private var url: URL? {
        guard let triCode = triCode?.lowercased(), !triCode.isEmpty else { return nil }
        return URL(string: AppURLs.teamLogoURL(for: triCode))
    }

    var body: some View {
        if let url = url {
            CachedAsyncImage(url: url) { phase in
                logoContent(for: phase)
            }
            .frame(width: 40, height: 40)
        } else {
            placeholder
                .frame(width: 40, height: 40)
        }
    }

    @ViewBuilder
    private func logoContent(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            placeholder
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure:
            placeholder
        @unknown default:
            placeholder
        }
    }

    private var placeholder: some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .overlay(Image(systemName: "photo").font(.caption))
    }
}

struct CachedAsyncImage<Content: View>: View {
    let url: URL
    let content: (AsyncImagePhase) -> Content

    @State private var uiImage: UIImage?

    var body: some View {
        if let uiImage = uiImage {
            content(.success(Image(uiImage: uiImage)))
        } else {
            AsyncImage(url: url) { phase in
                if case .success(let image) = phase, let uiImage = image.asUIImage {
                    content(.success(Image(uiImage: uiImage)))
                        .onAppear {
                            LogoCache.shared.setImage(uiImage, forKey: url.absoluteString)
                            self.uiImage = uiImage
                        }
                } else {
                    content(phase)
                }
            }
        }
    }
}

extension Image {
    var asUIImage: UIImage? {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let uiImage = child.value as? UIImage {
                return uiImage
            }
        }
        return nil
    }
} 
