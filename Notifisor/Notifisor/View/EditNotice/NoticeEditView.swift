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
    @State var amount: Double?
    @State var selectedUnit: Unit = Unit.hour
    @State var date: Date = Date()
    @State var repeats: [RepeatDay] = Week.allCases.map { RepeatDay(week: $0) }

    @FocusState private var checkoutInFocus: CheckoutFocusable?
    enum CheckoutFocusable: Hashable {
        case title
        case amount
    }

    let isAddSheet: Bool

    private var selectedDays: [Int] {
        return repeats.filter { $0.isSelected }.map { $0.week.rawValue }
    }

    @ObservedRealmObject var notice: NoticeType

    init(_ notice: NoticeType? = nil) {
        self.isAddSheet = notice == nil
        self.notice = notice ?? NoticeType()
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("일정을 입력하세요", text: $text)
                        .focused($checkoutInFocus, equals: .title)
                        .submitLabel(.next)

                } header: {
                    SectionHeaderText(text: "할 일")
                }

                Section {
                    HStack(alignment: .center) {
                        TextField("목표치를 입력하세요", value: $amount, format: .number)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxWidth: 200)
                            .focused($checkoutInFocus, equals: .amount)
                            .submitLabel(.done)

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
                            dismiss()
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
                        if !isAddSheet { deleteNotification() }
                        addNotification()
                        saveNotice()
                        dismiss()
                    }
                    .disabled(text == "" || amount == nil)
                }
            }
            .onAppear {
                self.text = notice.title
                self.amount = notice.amount
                self.selectedUnit = notice.unit
                self.date = notice.noticeTime

                notice.repeats.forEach { repeats[$0-1].isSelected = true }

                if isAddSheet {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self.checkoutInFocus = .title
                    }
                }
            }
            .onSubmit {
                if checkoutInFocus == .title {
                    checkoutInFocus = .amount
                } else if checkoutInFocus == .amount {
                    checkoutInFocus = nil
                }
            }
        }
    }

    private func addNotification() {
        //MARK: - 단발성 알림
        if selectedDays.isEmpty {
            notificationManager.createRequest("\(text) \(date)-\(0)",
                                              body: "\(text) \(amount ?? 0)\(selectedUnit)",
                                              at: date)
        }
        //MARK: - 반복 알림
        selectedDays.forEach {
            notificationManager.createRequest("\(text) \(date)-\($0)",
                                              body: "\(text) \(amount ?? 0)\(selectedUnit)",
                                              at: date, weekday: $0)
        }
    }

    private func deleteNotification() {
        let ids: [String] = notificationManager.getIdentifier(from: notice)
        notificationManager.deleteRequest(ids)
    }

    private func saveNotice() {
        let newNotice = Notice()
        newNotice.title = text
        newNotice.amount = amount ?? 0
        newNotice.repeats.append(objectsIn: selectedDays)
        newNotice.unit = selectedUnit
        newNotice.noticeTime = date

        notificationRepository.updateInfo(notice, newNotice)
    }

}

struct NoticeEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeEditView()
    }
}
