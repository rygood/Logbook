//
//  EntrySpec.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Quick
import Nimble

final class EntrySpec: QuickSpec {


    override class func spec() {
        var entry: Entry!

        describe("Entry") {
            beforeEach {
                entry = Entry.testableMock()
            }
            
            it("to be initialized correctly") {
                expect(entry.logbookId).to(equal(Entry._testableLogbookId))
                expect(entry.date).to(equal(Entry._testableDate))
                expect(entry.name).to(equal(Entry._testableName))
                expect(entry.note).to(equal(Entry._testableNote))

            }
        }
    }

}
