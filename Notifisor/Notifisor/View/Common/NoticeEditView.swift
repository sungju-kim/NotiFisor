//
//  NoticeEditView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct NoticeEditView: View {
    // ViewModel Import 후 변경예정
    @State var text: String = ""
    var body: some View {
        NavigationView {
            Form {
                TextField("일정을 입력해주세요", text: $text)
            }
        }
    }
}

struct NoticeEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeEditView()
    }
}
