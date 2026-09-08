//
//  DownloadItem.swift
//  DownloadManagerSim
//
//  Created by CCS038 on 07/09/26.
//

import Foundation

enum DownloadState {
    case queued
    case downloading(progress: Double)
    case paused(progress: Double)
    case completed
    case failed
}

struct DownloadItem: Identifiable {
  let id = UUID()
  let fileName: String
  let fileSize: Double
  var state: DownloadState
}

extension DownloadItem {
    var statusText: String {
        switch state {
          case .queued:
            return "Waiting..."

          case .downloading(let progress):
            return "Downloading... \(progress)%"

          case .paused(let progress):
            return "Paused at \(progress)%"
          
          case .completed:
            return "Finished"
          
          case .failed:
            return "Failed"
        }
    }
    
    var currentProgress: Double? {
        switch state {
            case .downloading(let progress), .paused(let progress):
                return progress
            case .completed:
                return 100
            case .failed, .queued:
                return nil
        }
    }
}
