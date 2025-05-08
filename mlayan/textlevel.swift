//
//  textlevel.swift
//  mlayan
//
//  Created by shaden  on 08/11/1446 AH.
//
import SwiftUI

struct ScenarioDetailView: View {
    let scenario: Scenario
    @State private var selectedChoiceIndex: Int? = nil
    @Environment(\.dismiss) var dismiss // ✅ عشان نرجع تلقائيًا

    var body: some View {
        VStack(spacing: 20) {
            Text("المستوى \(scenario.level)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)

            // ✅ Scenario Box with custom background image
            ZStack {
                Image("scenario_box")
                    .resizable()
                    .scaledToFit()
                Text(scenario.description)
                    .multilineTextAlignment(.center)
                    .padding(30)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)

            // صورة ثابتة
            Image("meeting_illustration")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.horizontal)

            // الخيارات
            VStack(spacing: 15) {
                ForEach(Array(scenario.choices.enumerated()), id: \.offset) { index, choice in
                    FixedOptionButton(
                        text: choice.text,
                        label: optionLetter(for: index)
                    ) {
                        selectedChoiceIndex = index
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true) // ✅ نخفي زر الباك العادي
        .toolbar {
            // ✅ نضيف زر باك على اليمين
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss() // ✅ يرجع للماب
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                }
            }
        }
    }

    func optionLetter(for index: Int) -> String {
        switch index {
        case 0: return "أ"
        case 1: return "ب"
        case 2: return "ج"
        default: return ""
        }
    }
}

// ✅ Custom button with fixed design
struct FixedOptionButton: View {
    let text: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Image("Option")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 110)

                HStack {
                    Spacer()

                    Text(text)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.trailing, 75)
                }
                Text(label)
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 36, height: 36)
                    .foregroundColor(.black)
                    .padding(.leading, 300)
            }
        }
        .frame(height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ScenarioDetailView(scenario: scenarios[0])
        .environment(\.layoutDirection, .rightToLeft)
}
