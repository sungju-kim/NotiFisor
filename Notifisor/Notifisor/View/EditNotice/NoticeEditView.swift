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
    @State var per: NumbersOnly = NumbersOnly()
    @State var selectedUnit: Unit = Unit.hour
    @State var date: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("일정을 입력해주세요", text: $text)

                Section {
                    VStack(alignment: .center) {
                        TextField("", text: $per.value)
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .frame(maxWidth: 200)

                        Spacer()

                        Picker("단위", selection: $selectedUnit) {
                            ForEach(Unit.allCases, id: \.self) {
                                Text($0.text)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("얼마나 하시겠어요?")
                }

                Section {
                    DatePicker(selection: $date, displayedComponents: .hourAndMinute) {

                    }
                    .datePickerStyle(.wheel)
                } header: {
                    Text("하루 중 언제 알려드릴까요?")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {

                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {

                    }
                }
            }
        }
    }
}

struct NoticeEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeEditView()
    }
}
