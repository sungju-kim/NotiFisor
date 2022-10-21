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
    @Environment(\.calendar) private var calendar
    @EnvironmentObject private var notificationManager: NotificationManager

    @State var text: String = ""
    @State var per: NumbersOnly = NumbersOnly()
    @State var selectedUnit: Unit = Unit.hour
    @State var date: Date = Date()
    @State var repeats: [RepeatDay] = [
        RepeatDay(weekDay: .everySunday),
        RepeatDay(weekDay: .everyMonday),
        RepeatDay(weekDay: .everyTuesday),
        RepeatDay(weekDay: .everyWednesday),
        RepeatDay(weekDay: .everyThursday),
        RepeatDay(weekDay: .everyFriday),
        RepeatDay(weekDay: .everySaturday)
    ]

    private var selectedDays: [Int] {
        return repeats.filter { $0.isSelected }.map { $0.toInt }
    }

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
                    RepeatSectionView(days: $repeats)
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
                        addNotice(text: text, per: per, selecedUnit: selectedUnit, date: date, repeats: selectedDays)
                        addNotification()
                        saveContext()
                        dismiss()
                    }
                }
            }
        }
    }
    //MARK: - selectedDays == [-1] 이면, 단발성 알림
    func addNotification() {
        selectedDays.forEach {
            notificationManager.createRequest("\(text) \(date)-\($0)", body: "\(text) \(per)\(selectedUnit)", at: date, weekday: $0)
        }
    }

    func addNotice(text: String, per: NumbersOnly, selecedUnit: Unit, date: Date, repeats: [Int]) {
        let newNotice = Notice(context: managedObjectContext)

        newNotice.title = text
        newNotice.amount = Int64(per.value) ?? 1
        newNotice.unit = selectedUnit.text
        newNotice.noticeTime = date
        newNotice.repeats = repeats
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
