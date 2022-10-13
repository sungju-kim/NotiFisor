//
//  DailyNoticeView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import SwiftUI

struct DailyNoticeView: View {
    @State var showSheet = false
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $showSheet) {
                    NoticeEditView()
                }
            }
            .padding()

            ScrollView {
                VStack(spacing: 30) {
                    ForEach(0..<10) { _ in
                        DailyNoticeCell()
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.systemGray5))

    }
}

struct DailyNoticeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyNoticeView()
    }
}
