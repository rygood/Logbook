//
//  EntrySpec.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Foundation
import Quick
import Nimble

final class EntrySpec: QuickSpec {


    override class func spec() {
        var entry: Entry!
        var entryViewModel: EntryViewModel!
        var entryPreviewableMock: Entry!

        describe("Entry") {
            beforeEach {
                entry = .testableMock()
                entryViewModel = .testableMock()
                entryPreviewableMock = .previewableMock()
            }
            
            it("should be initialized correctly") {
                expect(entry.logbookId).to(equal(Entry._testableLogbookId))
                expect(entry.date).to(equal(Entry._testableDate))
                expect(entry.name).to(equal(Entry._testableName))
                expect(entry.note).to(equal(Entry._testableNote))

            }

            it("should be initialized now from logbookId and EntryViewModel correctly") {
                let entryNow = Entry.now(Entry._testableLogbookId,
                                         entryViewModel: entryViewModel)
                expect(entryNow.logbookId).to(equal(Entry._testableLogbookId))
                expect(entryNow.name).to(equal(entryViewModel.name))
                expect(entryNow.note).to(equal(entryViewModel.note))
                // Times should be relatively close
                expect(entryNow.date.distance(to: Date.now)).to(beLessThan(0.05))
            }

            it("should be updated correctly") {
                let oldEntry = entry
                let updatingEntryViewModel = EntryViewModel(logbookId: "987654321",
                                                            date: Date.distantFuture,
                                                            name: "Updated Entry",
                                                            note: "Updated.")
                entry.update(from: updatingEntryViewModel)

                expect(oldEntry).toNot(equal(entry))
            }

            it("should be previewable") {
                expect(entryPreviewableMock.logbookId).to(equal(Entry._previewableLogbookId))
                expect(entryPreviewableMock.name).to(equal(Entry._previewableName))
                expect(entryPreviewableMock.date).to(equal(Entry._previewableDate))
                expect(entryPreviewableMock.note).to(equal(Entry._previewableNote))
            }
        }
    }

}
