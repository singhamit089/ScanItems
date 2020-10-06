//
//  Utility.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import Foundation

enum IdentifyingKeys: String {
    case cartUpdated
    case firstLaunch
}

extension Array {
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: chunkSize).map {
            Array(self[$0 ..< Swift.min($0 + chunkSize, self.count)])
        }
    }
}
