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
    
    func startDownload(id: UUID) {
        if let index = downloads.firstIndex(where: { $0.id == id }) {
            downloads[index].state = .downloading(progress: 0.0)
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                
                guard let currentIndex = self.downloads.firstIndex(where: { $0.id == id }) else {
                    timer.invalidate()
                    return
                }
                
                let item = self.downloads[currentIndex]
                if case .downloading(let currentProgress) = item.state {
                    let newProgress = currentProgress + 2.0
                    if newProgress >= 100.0 {
                        self.downloads[currentIndex].state = .completed
                        timer.invalidate()
                    } else {
                        self.downloads[currentIndex].state = .downloading(progress: newProgress)
                    }
                }
            }
        }
    }
    
    func pauseDownload(id: UUID) {
        if let index = downloads.firstIndex(where: { $0.id == id }) {
            let item = downloads[index]
            if case .downloading(let progress) = item.state {
                downloads[index].state = .paused(progress: progress)
            }
        }
    }
    
    func toggleDownload(for id: UUID) {
        if let index = downloads.firstIndex(where: { $0.id == id }) {
            let item = downloads[index]
            
            switch item.state {
            case .downloading:
                pauseDownload(id: id)
            case .failed, .queued, .paused:
                startDownload(id: id)
            case .completed:
                break
            }
        }
    }
}
