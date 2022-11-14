//
//  DailyNoticeUsecase.swift
//  Notifisor
//
//  Created by dale on 2022/11/14.
//

import Foundation

final class DailyNoticeUsecase: ObservableObject {
    @Published var day: Day?

    private let today: Date = .now

    private lazy var id = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: today)
    }()

    private var repository = NoticeRepository.shared

    init() {
        fetchDay()
    }

    func fetchDay() {
        guard let weekday = repository.get(Weekday.self, today.get(.weekday)) as? Weekday else { return }
        let day = Day()

        day._id = id
        day.notices = weekday.notices
        day.date = today
        if repository.get(Day.self, id) == nil {
            repository.add(day)
        }

        self.day = day
    }
}
