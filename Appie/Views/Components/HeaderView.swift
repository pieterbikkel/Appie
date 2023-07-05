//
//  HeaderView.swift
//  Appie
//
//  Created by Pieter Bikkel on 01/07/2023.
//

import SwiftUI

struct HeaderView: View {
    
    var size: CGSize
    var safeArea: EdgeInsets
    @State private var offsetY: CGFloat = 0
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HeaderView()
                    /// Making to Top
                        .zIndex(1000)
                    
                    VStack(spacing: 15) {
                        ForEach(vm.products, id: \.webshopID) { product in
                            NavigationLink(destination: ProductDetailView(webshopId: product.webshopID ?? 0, currentPrice: product.currentPrice ?? 0.0, priceBeforeBonus: product.priceBeforeBonus ?? 0.0, isBonus: product.isBonus ?? false)) {
                                    ProductListItem(product: product)
                                        .frame(height: 120)
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .id("SCROLLVIEW")
                .background {
                    ScrollDetector { offset in 
                        offsetY = -offset
                    } onDraggingEnd: { offset, velocity in
                        /// Resetting to Intial State, if not Completely Scrolled
                        let headerHeight = (size.height * 0.3) + safeArea.top
                        let minimumHeaderHeight = 65 + safeArea.top
                        
                        let targetEnd = offset + (velocity * 45)
                        if targetEnd < (headerHeight - minimumHeaderHeight) && targetEnd > 0 {
                            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                                scrollProxy.scrollTo("SCROLLVIEW", anchor: .top)
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView() -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        /// Converting Offset into Progress
        /// Limiting it to 0 - 1
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(Color.theme.black.gradient)
                
                VStack(spacing: 0) {
                    /// Profile Image
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        /// Since Scaling of the Image is 0.3 (1 - 0.7)
                        let halfScaledHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding: CGFloat = 15
                        let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding))
                        
                        Image("logo-inverse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .frame(width: rect.width, height: rect.height)
                            .clipShape(Circle())
                            /// Scaling Image
                            .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                            /// Moving Scaled Image to Center Leading
                            .offset(x: -(rect.minX - 15) * progress, y: -resizedOffsetY * progress)
                    }
                    .frame(width: headerHeight * 0.5, height: headerHeight * 0.5)
                    
                    SearchBar(searchText: $vm.searchText)
                        /// Advanced Method (Same as the Profile Image)
                        .moveText(progress, headerHeight - 300, minimumHeaderHeight)
                        .offset(x: (25) * progress)
                }
                .padding(.top, safeArea.top)
                .padding(.bottom, 15)
            }
            /// Resizing Header
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            /// Sticking to the Top
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden)
        }.environmentObject(dev.homeVM)
    }
}

fileprivate extension View {
    func moveText(_ progress: CGFloat, _ headerHeight: CGFloat, _ minimumHeaderHeight: CGFloat) -> some View {
        self
            .hidden()
            .overlay {
                GeometryReader { proxy in
                    let rect = proxy.frame(in: .global)
                    let midY = rect.midY
                    /// Half Scaled Text Height (Since Text Scaling will be 0.85 (1 - 0.15))
                    let halfScaledTextHeight = (rect.height * 0.85) / 2
                    /// Profile Image
                    let profileImageHeight = (headerHeight * 0.5)
                    /// Since Image Scaling will be 0.3 (1 - 0.7)
                    let scaledImageHeight = profileImageHeight * 0.3
                    let halfScaledImageHeight = scaledImageHeight / 2
                    /// Applied VStack Spacing is 15
                    /// 15 / 0.3 = 4.5 (0.3 -> Image Scaling)
                    let vStackSpacing: CGFloat = 4.5
                    let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledTextHeight - vStackSpacing - halfScaledImageHeight))
                    
                    self
                        .scaleEffect(1 - (progress * 0.15))
                        .offset(y: -resizedOffsetY * progress)
                }
            }
    }
}
