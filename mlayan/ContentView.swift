//
//  ContentView.swift
//  mlayan
//
//  Created by shaden  on 06/11/1446 AH.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedScenario: Scenario? = nil

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    let imageWidth = geo.size.width
                    let imageHeight = getImageHeight(forWidth: imageWidth)

                    ZStack {
                        Image("allLevelsBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageWidth, height: imageHeight)

                        // ✅ Level 10 button
                        levelButton(level: 10, x: imageWidth * 0.3, y: imageHeight * 0.18)

                        // ✅ Level 9 button
                        levelButton(level: 9, x: imageWidth * 0.7, y: imageHeight * 0.25)

                        // ✅ Level 8 button
                        levelButton(level: 8, x: imageWidth * 0.3, y: imageHeight * 0.30)

                        // ✅ Level 7 button
                        levelButton(level: 7, x: imageWidth * 0.7, y: imageHeight * 0.38)

                        // ✅ Level 6 button
                        levelButton(level: 6, x: imageWidth * 0.3, y: imageHeight * 0.45)

                        // ✅ Level 5 button
                        levelButton(level: 5, x: imageWidth * 0.7, y: imageHeight * 0.50)

                        // ✅ Level 4 button
                        levelButton(level: 4, x: imageWidth * 0.3, y: imageHeight * 0.58)

                        // ✅ Level 3 button
                        levelButton(level: 3, x: imageWidth * 0.7, y: imageHeight * 0.66)

                        // ✅ Level 2 button
                        levelButton(level: 2, x: imageWidth * 0.3, y: imageHeight * 0.73)

                        // ✅ Level 1 button
                        levelButton(level: 1, x: imageWidth * 0.7, y: imageHeight * 0.80)


                    }
                    .frame(width: imageWidth, height: imageHeight)
                }
                .scrollContentBackground(.hidden) // ✅ يخفي أي خلفية للسكرول
                .ignoresSafeArea(edges: .all)     // ✅ يخليه يمسك كل الشاشة فعلاً
            }
            .background(
                NavigationLink(
                    destination: selectedScenario.map {
                        ScenarioDetailView(scenario: $0)
                            .environment(\.layoutDirection, .rightToLeft)
                    },
                    isActive: Binding<Bool>(
                        get: { selectedScenario != nil },
                        set: { if !$0 { selectedScenario = nil } }
                    )
                ) {
                    EmptyView()
                }
            )
            .navigationBarHidden(true)
            .ignoresSafeArea() // ✅ كمان NavigationView نطنشه من SafeArea
        }
    }

    @ViewBuilder
    func levelButton(level: Int, x: CGFloat, y: CGFloat) -> some View {
        Button(action: {
            selectedScenario = scenarios.first(where: { $0.level == level })
        }) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 140, height: 120)
                .background(
                    Color.blue.opacity(0.2) // مؤقت للتجريب
                )
                .cornerRadius(12)
                .overlay(
                    Text("\(level)")
                        .foregroundColor(.white)
                        .font(.caption)
                        .opacity(0.8)
                )
        }
        .position(x: x, y: y)
    }

    func getImageHeight(forWidth width: CGFloat) -> CGFloat {
        guard let uiImage = UIImage(named: "allLevelsBackground") else { return 0 }
        let aspectRatio = uiImage.size.height / uiImage.size.width
        return width * aspectRatio
    }
}
