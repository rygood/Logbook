//
//  EntryViewModelSpec.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Foundation
import Quick
import Nimble

final class EntryViewModelSpec: QuickSpec {

    override class func spec() {
        var entryViewModel: EntryViewModel!
        var entryViewModelTestableMock: EntryViewModel!
        var entryViewModelPreviewableMock: EntryViewModel!

        describe("EntryViewModel") {
            beforeEach {
                entryViewModel = EntryViewModel()
                entryViewModelTestableMock = .testableMock()
                entryViewModelPreviewableMock = .previewableMock()
            }

            it("should be initialized correctly") {
                expect(entryViewModelTestableMock.logbookId).to(equal(EntryViewModel._testableLogbookId))
                expect(entryViewModelTestableMock.name).to(equal(EntryViewModel._testableName))
                expect(entryViewModelTestableMock.date).to(equal(EntryViewModel._testableDate))
                expect(entryViewModelTestableMock.note).to(equal(EntryViewModel._testableNote))
            }

            it("should default to empty values with a now date") {
                expect(entryViewModel.logbookId).to(beEmpty())
                expect(entryViewModel.name).to(beEmpty())
                expect(entryViewModel.date.distance(to: Date.now)).to(beLessThan(0.05))
                expect(entryViewModel.note).to(beEmpty())
            }

            it("should be updated correctly") {
                let oldEntryViewModel = entryViewModel
                let updatingEntry = Entry(name: "Updated EntryViewModel",
                                          date: Date.distantFuture,
                                          logbookId: "987654321",
                                          note: "Updated.")
                entryViewModel.update(from: updatingEntry)

                expect(oldEntryViewModel).toNot(equal(entryViewModel))
            }

            it("should be updated if the Entry's Note is nil") {
                let oldEntryViewModel = entryViewModel
                let updatingEntry = Entry(name: "Updated EntryViewModel",
                                          date: Date.distantFuture,
                                          logbookId: "987654321",
                                          note: nil)
                entryViewModel.update(from: updatingEntry)

                expect(oldEntryViewModel).toNot(equal(entryViewModel))
                expect(entryViewModel.note).to(beEmpty())
            }

            it("should be equatable") {
                let otherEntryViewModel = entryViewModel

                expect(otherEntryViewModel).to(equal(entryViewModel))
            }

            it("should be previewable") {
                expect(entryViewModelPreviewableMock.logbookId).to(equal(EntryViewModel._previewableLogbookId))
                expect(entryViewModelPreviewableMock.name).to(equal(EntryViewModel._previewableName))
                expect(entryViewModelPreviewableMock.date).to(equal(EntryViewModel._previewableDate))
                expect(entryViewModelPreviewableMock.note).to(equal(EntryViewModel._previewableNote))
            }
        }
    }
}
