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
    @State var amount: NumbersOnly = NumbersOnly()
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

    @FocusState private var checkoutInFocus: CheckoutFocusable?
    enum CheckoutFocusable: Hashable {
      case title
      case amount
    }

    let isAddSheet: Bool
    @ObservedObject var notice: Notice

    private var selectedDays: [Int] {
        return repeats.filter { $0.isSelected }.map { $0.toInt }
    }

    init(_ notice: Notice? = nil) {
        self.isAddSheet = notice == nil ? true : false
        self.notice = notice ?? Notice()
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("일정을 입력해주세요", text: $text)
                        .focused($checkoutInFocus, equals: .title)

                } header: {
                    SectionHeaderText(text: "할 일")
                }

                Section {
                    VStack(alignment: .center) {
                        TextField("목표치를 입력해주세요.", text: $amount.value)
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .frame(maxWidth: 200)
                            .focused($checkoutInFocus, equals: .amount)

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
            .navigationTitle( isAddSheet ? "알림 추가" : "알림 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        //MARK: - Notice 추가
                        if isAddSheet {
                            addNotification()
                            dismiss()
                        //MARK: - Notice 편집
                        } else {
                            dismiss()
                        }
                    }
                }
            }
            .onAppear {
                //MARK: - Notice 편집
                if !isAddSheet {

                //MARK: - Notice 추가
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self.checkoutInFocus = .title
                    }
                }
            }
            .onSubmit {
                if checkoutInFocus == .title {
                    checkoutInFocus = .amount
                }
            }
        }
    }

    private func addNotification() {
        //MARK: - 단발성 알림
        if selectedDays.isEmpty {
            notificationManager.createRequest("\(text) \(date)-\(0)",
                                              body: "\(text) \(amount)\(selectedUnit)",
                                              at: date)
        }
        //MARK: - 반복 알림
        else {
            selectedDays.forEach {
                notificationManager.createRequest("\(text) \(date)-\($0)",
                                                  body: "\(text) \(amount)\(selectedUnit)",
                                                  at: date, weekday: $0)
            }
        }
    }

}

struct NoticeEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeEditView()
    }
}
