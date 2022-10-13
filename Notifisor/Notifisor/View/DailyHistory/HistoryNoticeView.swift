//
//  HistoryNoticeView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct HistoryNoticeView: View {
    private let date: Date = .now
    private var text: String = {
        let date = Date.now.split()
        return "\(date[0])년 \(date[1])월 \(date[2])일"
    }()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10) { _ in
                        HistoryNoticeCell()
                    }
                }
                .padding(.horizontal)
            }
            .background(Color(.systemGray5))
            .navigationTitle(text)
        }
    }
}

struct HistoryNoticeView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryNoticeView()
    }
}
