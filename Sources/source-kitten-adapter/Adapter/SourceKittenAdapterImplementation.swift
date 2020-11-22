//
//  SourceKittenAdapterImplementation.swift
//  source-kitten-adapter
//
//  Created by incetro on 11/22/20.
//

import Files
import ShellOut
import Foundation

// MARK: - SourceKittenAdapterImplementation

public final class SourceKittenAdapterImplementation {
}

// MARK: - SourceKittenAdapterImplementation

extension SourceKittenAdapterImplementation: SourceKittenAdapter {

    public func dictionary(forFileAt url: String) throws -> JSONDictionary {

        /// Clear environment from previous files if they are eixst
        if let folder = Folder.current.subfolders.first(where: { $0.name == Constants.interlayerFolderName }) {
            try folder.delete()
        }

        /// Copy target file to interlayer directory
        let workingFolder = try Folder.current.createSubfolder(named: Constants.interlayerFolderName)
        let targetFile = try File(path: url)
        try targetFile.copy(to: workingFolder)

        /// Do SourceKitten work
        let sourceKittenScript = Constants.sourceKittenScript(
            inputFilePathString: targetFile.path,
            outputFilePathString: workingFolder.path,
            filename: targetFile.name
        )
        try shellOut(to: sourceKittenScript)

        /// Transform SourceKitten output to dictionary
        let sourceKitContent = try workingFolder
            .file(named: targetFile.name + "." + Constants.outputFileExtension)
            .readAsString()
        guard let data = sourceKitContent.data(using: .utf8) else {
            fatalError()
        }
        guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? JSONDictionary else {
            fatalError()
        }

        /// Clear interlayer folder
        try workingFolder.delete()

        return json
    }
}
