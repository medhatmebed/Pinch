//
//  ContentView.swift
//  Pinch
//
//  Created by Medhat Mebed on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    func resetImageState() {
        return withAnimation(.spring) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                //MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 12, x: 2, y:2)
                    .opacity(isAnimating ? 1 : 0).animation(.linear(duration: 1), value: isAnimating)
                    .offset(x:imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                // MARK: - TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    })
                // MARK: - DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear) {
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                // MARK: - 3. MAGNIFICATION
                  .gesture(
                    MagnificationGesture()
                      .onChanged { value in
                        withAnimation(.linear(duration: 1)) {
                          if imageScale >= 1 && imageScale <= 5 {
                            imageScale = value
                          } else if imageScale > 5 {
                            imageScale = 5
                          }
                        }
                      }
                      .onEnded { _ in
                        if imageScale > 5 {
                          imageScale = 5
                        } else if imageScale <= 1 {
                          resetImageState()
                        }
                      }
                  )
            } //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            })
            // MARK: - INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            
            // MARK: - CONTROLS
            .overlay(
                Group {
                    HStack {
                        // SCALE DOWN
                        Button {
                            if imageScale > 1 {
                                imageScale -= 1
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // RESET
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // SCALE UP
                        Button {
                            if imageScale < 5 {
                                imageScale += 1
                                
                                if imageScale >= 5 {
                                    imageScale = 5
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    } //: CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30)
                , alignment : .bottom
            )
            
        } //: NAVIGATION
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
