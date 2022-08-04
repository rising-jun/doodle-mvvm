//
//  TestUtil.swift
//  DoodleMVVMTests
//
//  Created by 김동준 on 2022/08/03.
//

import Foundation

final class TestUtil {
    static func loadJSON(_ fileName: String) -> Data? {
        guard let path = Bundle.init(for: TestUtil.self).path(forResource: fileName, ofType: "json") else { return nil }
        let fileURL = URL(fileURLWithPath: path)
        guard let data = try? Data.init(contentsOf: fileURL) else { return nil }
        return data
    }
}
