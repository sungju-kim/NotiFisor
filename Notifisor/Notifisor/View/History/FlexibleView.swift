//
//  FlexibleView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/12/01.
//

import SwiftUI

struct FlexibleView: View {
    @State private var showDetail = false
    let data: CurrentNotice
    let amount: Double
    private var textMessage: String {
        "\(data.title)를 총 \(amount)\(data.unit.text) 했습니다."
    }
    
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
                Text(textMessage)
                    .padding(.top, 30)
            }
        }
        .shadowCellStyle()
        .onTapGesture {
            withAnimation {
                self.showDetail.toggle()
            }
        }
    }
}
