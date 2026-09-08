//
//  DownloadManagerViewModel.swift
//  DownloadManagerSim
//
//  Created by CCS038 on 08/09/26.
//
import Foundation

@Observable
class DownloadManagerViewModel {
    var downloads: [DownloadItem] = [
        DownloadItem(fileName: "FileA", fileSize: 22.4, state: .downloading(progress: 50.0)),
        DownloadItem(fileName: "FileB", fileSize: 24.0, state: .queued),
        DownloadItem(fileName: "FileC", fileSize: 17.2, state: .completed)
    ]
}
