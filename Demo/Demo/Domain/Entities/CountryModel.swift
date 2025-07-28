//
//  CountryModel.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation

struct CountryModel: Decodable, Identifiable, Hashable {
    var id: UUID = UUID()
    let commonName: String
    let officialName: String
    let flagURL: String
    let currencies: [String: CurrencyModel]
    var capital: [String]
    var timezones: [String]
    
    // Custom initializer for creating instances directly
    init(commonName: String, officialName: String, flagSvg: String, currencies: [String: CurrencyModel], capital: [String], timezones: [String]) {
        self.commonName = commonName
        self.officialName = officialName
        self.flagURL = flagSvg
        self.currencies = currencies
        self.capital = capital
        self.timezones = timezones
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case flags
        case currencies
        case capital
        case timezones
    }
    
    enum FlagsKeys: String, CodingKey {
        case png
    }
    
    enum NameKeys: String, CodingKey {
        case common
        case official
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.currencies = try container.decode([String : CurrencyModel].self, forKey: .currencies)
        self.capital = try container.decode([String].self, forKey: .capital)
        self.timezones = try container.decode([String].self, forKey: .timezones)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        self.commonName = try nameContainer.decode(String.self, forKey: .common)
        self.officialName = try nameContainer.decode(String.self, forKey: .official)
        
        let flagsContainer = try container.nestedContainer(keyedBy: FlagsKeys.self, forKey: .flags)
        self.flagURL = try flagsContainer.decode(String.self, forKey: .png)
    }
    
    static func == (lhs: CountryModel, rhs: CountryModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.commonName == rhs.commonName &&
            lhs.officialName == rhs.officialName &&
            lhs.flagURL == rhs.flagURL &&
            lhs.currencies == rhs.currencies &&
            lhs.capital == rhs.capital &&
            lhs.timezones == rhs.timezones
    }
    
    static func mock() -> CountryModel {
        return CountryModel(
            commonName: "United States",
            officialName: "United States of America",
            flagSvg: "https://flagcdn.com/us.svg",
            currencies: [
                "USD": CurrencyModel(name: "United States dollar", symbol: "$")
            ],
            capital: ["Washington, D.C."],
            timezones: ["UTC-12:00", "UTC-11:00", "UTC-10:00", "UTC-09:00", "UTC-08:00", "UTC-07:00", "UTC-06:00", "UTC-05:00", "UTC-04:00", "UTC+10:00", "UTC+12:00"]
        )
    }
}

struct CurrencyModel: Decodable, Hashable {
    let name: String
    let symbol: String
    
    static func == (lhs: CurrencyModel, rhs: CurrencyModel) -> Bool {
        return lhs.name == rhs.name && lhs.symbol == rhs.symbol
    }
}
