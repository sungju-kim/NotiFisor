//
//  NoticeEditView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct NoticeEditView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) private var dismiss
    // ViewModel Import 후 변경예정
    @State var text: String = ""
    @State var per: NumbersOnly = NumbersOnly()
    @State var selectedUnit: Unit = Unit.hour
    @State var date: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("일정을 입력해주세요", text: $text)
                } header: {
                    SectionHeaderText(text: "할 일")
                }

                Section {
                    VStack(alignment: .center) {
                        TextField("목표치를 입력해주세요.", text: $per.value)
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .frame(maxWidth: 200)

                        Divider()

                        Picker("단위", selection: $selectedUnit) {
                            ForEach(Unit.allCases, id: \.self) {
                                Text($0.text)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                    }
                } header: {
                    SectionHeaderText(text: "목표 설정")
                }

                Section {
                    DatePicker(selection: $date, displayedComponents: .hourAndMinute) {

                    }
                    .datePickerStyle(.wheel)
                } header: {
                    SectionHeaderText(text: "알림 시간")
                }
                
                Section {
                    RepeatSectionView()
                } header: {
                    SectionHeaderText(text: "반복")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        addNotice(text: text, per: per, selecedUnit: selectedUnit, date: date)
                        saveContext()
                        dismiss()
                    }
                }
            }
        }
    }

    func addNotice(text: String, per: NumbersOnly, selecedUnit: Unit, date: Date) {
        let newNotice = Notice(context: managedObjectContext)

        newNotice.title = text
        newNotice.amount = Int64(per.value) ?? 1
        newNotice.unit = selectedUnit.text
        newNotice.noticeTime = date
    }

    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("error")
        }
    }
}

struct NoticeEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeEditView()
    }
}
