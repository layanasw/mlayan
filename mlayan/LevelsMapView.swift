//
//  LevelsMapView.swift
//  mlayan
//
//  Created by shaden  on 06/11/1446 AH.
//
import SwiftUI

struct LevelsMapView: View {
    @State private var selectedLevel: Int? = nil
    @Namespace private var animation

    let levels = Array(1...7)

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(levels, id: \.self) { level in
                        VStack(spacing: 0) {
                            HStack {
                                if level % 2 == 0 {
                                    Spacer()
                                }

                                LevelView(level: level, isSelected: selectedLevel == level, animation: animation)
                                    .frame(width: UIScreen.main.bounds.width * 0.75)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            selectedLevel = level
                                        }
                                    }

                                if level % 2 != 0 {
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 10)

                            if level != levels.last {
                                HStack {
                                    if level % 2 == 0 {
                                        Spacer()
                                        StairView(alignment: .right)
                                            .frame(width: 60, height: 60)
                                    } else {
                                        StairView(alignment: .left)
                                            .frame(width: 60, height: 60)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 40)
            }
            .background(Color.gray.edgesIgnoringSafeArea(.all))

            // FULL SCREEN ZOOM-IN VIEW (no need for a new image now)
            if let selectedLevel = selectedLevel {
                ZStack(alignment: .topTrailing) {
                    Color("Map").ignoresSafeArea()

                    Image("office\(selectedLevel)")
                        .resizable()
                        .scaledToFill()
                        .matchedGeometryEffect(id: selectedLevel, in: animation)
                        .ignoresSafeArea()

                    Button(action: {
                        withAnimation(.spring()) {
                            self.selectedLevel = nil
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                }
                .transition(.opacity)
            }
        }
    }
}

struct LevelView: View {
    let level: Int
    let isSelected: Bool
    var animation: Namespace.ID

    var body: some View {
        ZStack {
            Image("office\(level)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .shadow(radius: 5)
                .matchedGeometryEffect(id: level, in: animation)
        }
    }
}

struct StairView: View {
    let alignment: AlignmentSide

    var body: some View {
        Image("stairs")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(alignment == .left ? Angle(degrees: -45) : Angle(degrees: 45))
    }
}


enum AlignmentSide {
    case left, right
}

struct LevelsMapView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsMapView()
    }
}
