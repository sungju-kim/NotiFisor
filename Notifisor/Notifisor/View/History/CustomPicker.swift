//
//  CustomPicker.swift
//  Notifisor
//
//  Created by dale on 2022/11/21.
//

import SwiftUI

struct CustomPicker: View {
    let months: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let startYear: Int = 2000
    let endYear: Int = Date.kst.get(.year)

    @Binding var date: Date
    @Binding var year: Int
    @Binding var month: Int
    @Binding var isShowing: Bool

    var body: some View {
        HStack {
            Text("\(String(year))년 \(month)월")
                .font(.title)
            Button {
                withAnimation {
                    isShowing.toggle()
                }
            } label: {
                Image(systemName: "chevron.down")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .rotationEffect(Angle(degrees: isShowing ? 0 : 90))
            }
        }
        .padding()

        if isShowing {
            HStack {
                Picker("", selection: $year) {
                    ForEach(startYear...endYear, id: \.self) {
                        Text(String($0))
                            .font(.title3)
                    }
                }
                .frame(width: 150)
                .clipped()

                Picker("", selection: $month) {
                    ForEach(months, id: \.self) {
                        Text(String($0))
                            .font(.title3)
                    }
                }
                .frame(width: 150)
                .clipped()
            }
            .font(.title)
            .background(Constant.background)
            .containerShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            .transition(.scale(scale: 0.1, anchor: .top))
            .padding()
            .pickerStyle(.inline)
            .onChange(of: year) { _ in
                updateDate()
            }
            .onChange(of: month) { _ in
                updateDate()
            }
        }
    }
    func updateDate() {
        var dateComponent = DateComponents()
        dateComponent.year = year
        dateComponent.month = month
        date = Calendar.current.date(from: dateComponent) ?? .now
    }
}

