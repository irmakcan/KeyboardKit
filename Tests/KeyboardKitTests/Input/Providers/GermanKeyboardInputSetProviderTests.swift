//
//  GermanKeyboardInputSetProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class GermanKeyboardInputSetProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: KeyboardInputSetProvider!
        
        beforeEach {
            provider = GermanKeyboardInputSetProvider()
        }
        
        describe("input set provider") {
            
            it("has correct alphabetic input set") {
                expect(provider.alphabeticInputSet().inputRows).to(equal([
                    ["q", "w", "e", "r", "t", "z", "u", "i", "o", "p", "ü"],
                    ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ö", "ä"],
                    ["y", "x", "c", "v", "b", "n", "m"]
                ]))
            }
            
            it("has correct numeric input set") {
                let rows = provider.numericInputSet().inputRows
                let expected = NumericKeyboardInputSet.standard(currency: "€").inputRows
                expect(rows).to(equal(expected))
            }
            
            it("has correct symbolic input set") {
                let rows = provider.symbolicInputSet().inputRows
                let expected = SymbolicKeyboardInputSet.standard(currencies: ["$", "£", "¥"]).inputRows
                expect(rows).to(equal(expected))
            }
        }
    }
}