//
//  Autocomplete+TextReplacementDictionary.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-05.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type can be used to define text replacements to
    /// e.g. define custom autocorrections.
    struct TextReplacementDictionary {

        public init(
            _ initialValue: Dictionary = .init()
        ) {
            self.dictionary = initialValue
        }

        public typealias Dictionary = KeyboardLocale.Dictionary<[String: String]>

        private var dictionary: Dictionary = .init()
    }
}

public extension Autocomplete.TextReplacementDictionary {

    /// This predefined dictionary can be used as a starting
    /// point when defining a custom list of autocorrections.
    static var additionalAutocorrections: Self {
        .init(.init(
            [
                KeyboardLocale.english: [
                    "ill": "I'll",
                    "Ill": "I'll"
                ]
            ]
        ))
    }
}

public extension Autocomplete.TextReplacementDictionary {

    /// Insert a text replacement for a certain locale.
    mutating func addTextReplacement(
        for text: String,
        with replacement: String,
        locale: KeyboardLocaleInfo
    ) {
        addTextReplacements([text: replacement], for: locale)
    }

    /// Insert a text replacement for a certain locale.
    mutating func addTextReplacements(
        _ dict: [String: String],
        for locale: KeyboardLocaleInfo
    ) {
        var val = dictionary.value(for: locale) ?? [:]
        dict.forEach {
            val[$0.key] = $0.value
        }
        setTextReplacements(val, for: locale)
    }

    /// Set the text replacements for a certain locale.
    mutating func setTextReplacements(
        _ dict: [String: String],
        for locale: KeyboardLocaleInfo
    ) {
        dictionary.set(dict, for: locale)
    }

    /// Get a text replacement for a certain text and locale.
    func textReplacement(
        for text: String,
        locale: KeyboardLocaleInfo
    ) -> String? {
        textReplacements(for: locale)?[text]
    }

    /// Get all text replacements for a certain locale.
    func textReplacements(
        for locale: KeyboardLocaleInfo
    ) -> [String: String]? {
        dictionary.value(for: locale)
    }
}
