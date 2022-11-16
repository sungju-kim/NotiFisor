//
//  NoticeEditView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import RealmSwift
import SwiftUI

struct NoticeEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.calendar) private var calendar
    @EnvironmentObject private var notificationManager: NotificationManager
    @EnvironmentObject private var notificationRepository: NoticeRepository

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

    private var selectedDays: [Int] {
        return repeats.filter { $0.isSelected }.map { $0.toInt }
    }

    @ObservedRealmObject var notice: Notice

    init(_ notice: Notice? = nil) {
        self.isAddSheet = notice == nil
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
                if !isAddSheet {
                    HStack {
                        Spacer()
                        Button("알림 삭제", role: .destructive) {
                            deleteNotification()
                            notificationRepository.delete(notice)
                        }
                        Spacer()
                    }
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
                            addNotice()
                            dismiss()
                        //MARK: - Notice 편집
                        } else {
                            editNotification()
                            editNotice()
                            dismiss()
                        }
                    }
                }
            }
            .onAppear {
                //MARK: - Notice 편집
                if !isAddSheet {
                    self.text = notice.title
                    self.amount = NumbersOnly(value: String(notice.amount))
                    self.selectedUnit = notice.unit
                    self.date = notice.noticeTime
                    Array(notice.repeats).forEach { weekday in
                        repeats[weekday-1].isSelected = true
                    }
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

    private func editNotification() {
        deleteNotification()
        addNotification()
    }

    private func deleteNotification() {
        let ids: [String] = notificationManager.getIdentifier(from: notice)
        notificationManager.deleteRequest(ids)
    }

    private func addNotice() {
        let notice = Notice()
        notice.title = text
        notice.amount = Int(amount.value) ?? 0
        notice.repeats.append(objectsIn: selectedDays)
        notice.unit = selectedUnit
        notice.noticeTime = date
        notificationRepository.add(notice)
    }

    private func editNotice() {
        let edittedNotice = Notice()
        edittedNotice.title = text
        edittedNotice.amount = Int(amount.value) ?? 0
        edittedNotice.unit = selectedUnit
        edittedNotice.noticeTime = date
        edittedNotice.repeats.append(objectsIn: selectedDays)
        notificationRepository.updateInfo(notice, edittedNotice)
    }
}

struct NoticeEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeEditView()
    }
}
