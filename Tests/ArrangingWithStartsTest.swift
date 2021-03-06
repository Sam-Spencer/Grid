//
//  ArrangingWithStartsTest.swift
//  GridTests
//
//  Created by Denis Obukhov on 06.05.2020.
//  Copyright © 2020 Exyte. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Grid

class ArrangingWithStartsTest: XCTestCase {

    private struct MockArranger: LayoutArranging {}
    private let arranger = MockArranger()

    func gridItem(index: Int) -> GridItem {
        GridItem(AnyView(EmptyView()), id: AnyHashable(index))
    }
    private lazy var gridItems: [GridItem] =
        (0..<15).map { self.gridItem(index: $0) }
    
    private lazy var spans =
        [GridSpan](repeating: .default, count: 6)
            + [
                [3, 1],
                [2, 1],
                [2, 2],
                [1, 1],
                [1, 10],
                [2, 3],
                [1, 3],
                [1, 1],
                [1, 1]
            ]

    private lazy var starts: [GridStart] =
        [GridStart](repeating: .default, count: 6)
            + [
                nil,
                nil,
                [5, 1],
                [nil, 2],
                [3, 0],
                nil,
                nil,
                [2, nil],
                nil
            ]
    
    func testArrangementDenseRows() throws {
        let arrangementsInfo =
            gridItems.enumerated().map { ArrangementInfo(gridItem: $1, start: starts[$0], span: spans[$0]) }
        let task = ArrangingTask(itemsInfo: arrangementsInfo,
                                 tracks: 4,
                                 flow: .rows,
                                 packing: .dense)

        let arrangement = arranger.arrange(task: task)

        XCTAssertEqual(arrangement, LayoutArrangement(columnsCount: 4, rowsCount: 10, items: [
            ArrangedItem(gridItem: gridItem(index: 10), startIndex: [3, 0], endIndex: [3, 9]),
            ArrangedItem(gridItem: gridItem(index: 13), startIndex: [2, 0], endIndex: [2, 0]),
            ArrangedItem(gridItem: gridItem(index: 8), startIndex: [0, 1], endIndex: [1, 2]),
            ArrangedItem(gridItem: gridItem(index: 9), startIndex: [2, 2], endIndex: [2, 2]),
            ArrangedItem(gridItem: gridItem(index: 0), startIndex: [0, 0], endIndex: [0, 0]),
            ArrangedItem(gridItem: gridItem(index: 1), startIndex: [1, 0], endIndex: [1, 0]),
            ArrangedItem(gridItem: gridItem(index: 2), startIndex: [2, 1], endIndex: [2, 1]),
            ArrangedItem(gridItem: gridItem(index: 3), startIndex: [0, 3], endIndex: [0, 3]),
            ArrangedItem(gridItem: gridItem(index: 4), startIndex: [1, 3], endIndex: [1, 3]),
            ArrangedItem(gridItem: gridItem(index: 5), startIndex: [2, 3], endIndex: [2, 3]),
            ArrangedItem(gridItem: gridItem(index: 6), startIndex: [0, 4], endIndex: [2, 4]),
            ArrangedItem(gridItem: gridItem(index: 7), startIndex: [0, 5], endIndex: [1, 5]),
            ArrangedItem(gridItem: gridItem(index: 11), startIndex: [0, 6], endIndex: [1, 8]),
            ArrangedItem(gridItem: gridItem(index: 12), startIndex: [2, 5], endIndex: [2, 7]),
            ArrangedItem(gridItem: gridItem(index: 14), startIndex: [2, 8], endIndex: [2, 8])
        ]))
    }
}
