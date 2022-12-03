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
    private var textMessage: String {
        "\(data.title)를 총 \(simpleAmount)\(data.unit.text) 했습니다."
    }
    
    private var simpleAmount: Double {
        (data.amount ?? 0) * Double(data.repeats.count)
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

struct FlexibleView_Previews: PreviewProvider {
    static var previews: some View {
        let currentNotice = CurrentNotice()
        currentNotice.title = "달리기"
        currentNotice.repeats.append(objectsIn: [1,3,5])
        currentNotice.unit = .km
        currentNotice.amount = 3
        
        return FlexibleView(data: currentNotice)
    }
}
