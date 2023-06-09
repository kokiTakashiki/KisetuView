import Foundation

public enum Kisetu: Int, CaseIterable {
    case 🌸
    case 😎
    case 🍁
    case 🧊

    public func detail() -> Detail {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)

        switch self {
        case .🌸:
            return Detail(
                kisetu: self,
                emoji: .🌸,
                astronomicalSeasonName: .spring,
                seasonStartDay: Detail.SeasonStartDay(
                    year: year,
                    month: .march,
                    day: 20
                )
            )
        case .😎:
            return Detail(
                kisetu: self,
                emoji: .😎,
                astronomicalSeasonName: .summer,
                seasonStartDay: Detail.SeasonStartDay(
                    year: year,
                    month: .june,
                    day: 20
                )
            )
        case .🍁:
            return Detail(
                kisetu: self,
                emoji: .🍁,
                astronomicalSeasonName: .autumn,
                seasonStartDay: Detail.SeasonStartDay(
                    year: year,
                    month: .september,
                    day: 20
                )
            )
        case .🧊:
            return Detail(
                kisetu: self,
                emoji: .🧊,
                astronomicalSeasonName: .winter,
                seasonStartDay: Detail.SeasonStartDay(
                    year: year,
                    month: .december,
                    day: 20
                )
            )
        }
    }
    public static func next(_ target: Kisetu) -> Kisetu {
        switch target {
        case .🌸: return .😎
        case .😎: return .🍁
        case .🍁: return .🧊
        case .🧊: return .🌸
        }
    }
}

public extension Kisetu {
    struct Detail: Equatable {
        private let id = UUID()
        public var kisetu: Kisetu
        public var emoji: Emoji
        public var astronomicalSeasonName: AstronomicalSeasonName
        public var seasonStartDay: SeasonStartDay

        public static func == (lhs: Detail, rhs: Detail) -> Bool{
            return lhs.id == rhs.id
        }
    }
}

extension Kisetu.Detail {
    public func timeUntilNextKisetu() -> Int? {
        let current = Calendar.current

        let nowKisetuDay = self.seasonStartDay
        let nowComponent = DateComponents(
            year: nowKisetuDay.year,
            month: nowKisetuDay.month.rawValue,
            day: nowKisetuDay.day
        )
        guard let nowKisetuDate = current.date(from: nowComponent) else { return nil }
        
        let next = Kisetu.next(self.kisetu)
        let nextKisetuDay = next.detail().seasonStartDay
        let nextComponent = DateComponents(
            year: nextKisetuDay.year,
            month: nextKisetuDay.month.rawValue,
            day: nextKisetuDay.day
        )
        guard let nextKisetuDate = current.date(from: nextComponent) else { return nil }

        let diff = current.dateComponents([.day], from: nowKisetuDate, to: nextKisetuDate)

        return diff.day
    }
}

public extension Kisetu.Detail {
    enum Emoji: String {
        case 🌸 = "🌸"
        case 😎 = "😎"
        case 🍁 = "🍁"
        case 🧊 = "🧊"
    }

    enum AstronomicalSeasonName: String {
        case spring = "Spring"
        case summer = "Summer"
        case autumn = "Autumn"
        case winter = "Winter"
    }

    struct SeasonStartDay {
        var year: Int
        var month: Month
        var day: Int
        public func toDate() -> Date {
            return Date()
        }
    }
}

public extension Kisetu.Detail.SeasonStartDay {
    enum Month: Int {
        case january = 1
        case february = 2
        case march = 3
        case april = 4
        case may = 5
        case june = 6
        case july = 7
        case august = 8
        case september = 9
        case october = 10
        case november = 11
        case december = 12
    }
}
