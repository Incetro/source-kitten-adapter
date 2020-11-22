//
//  File.swift
//  source-kitten-adapter
//
//  Created by incetro on 11/22/20.
//

import Foundation

// MARK: - Constants

public enum Constants {

    static let swiftExtension = "swift"
    static let interlayerFolderName = "incetro-working-directory"
    static let outputFileExtension = "txt"

    static func sourceKittenScript(
        inputFilePathString: String,
        outputFilePathString: String,
        filename: String
    ) -> String {
        "sourcekitten doc --single-file \(inputFilePathString) -- -j4 -sdk $(xcrun --show-sdk-path -sdk macosx) $(pwd)/\(inputFilePathString) > \(outputFilePathString)\(filename)" + "." + Constants.outputFileExtension
    }
}
