//
//  FlexibleView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/12/01.
//

import SwiftUI

struct FlexibleView: View {
    @State private var showDetail = false
    let data: [CurrentNotice: Double]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("가장 많이 수행한 미션은 무엇일까요?")
                    .font(.headline)
                
                Spacer()
                Button {
                    withAnimation {
                        self.showDetail.toggle()
                    }
                } label: {
                    Label("Detail", systemImage: "chevron.right")
                                            .labelStyle(.iconOnly)
                                            .imageScale(.large)
                                            .foregroundColor(Color(.systemGray))
                                            .rotationEffect(.degrees(showDetail ? 90 : 0))
                                            .padding()
                                            .animation(.easeInOut, value: showDetail)
                }
            }
            
            if showDetail {
                ForEach(data.sorted(by: <), id: \.key) {
                    Text("\($0.title)를 총 \(String(format: "%.1f", $1))\($0.unit.text) 했습니다.")
                        .padding(.top, 30)
                }
            }
        }
        .padding()
        .shadowCellStyle()
        .onTapGesture {
            withAnimation {
                self.showDetail.toggle()
            }
        }
    }
}
