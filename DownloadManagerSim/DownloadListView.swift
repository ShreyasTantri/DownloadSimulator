//
//  DownloadListView.swift
//  DownloadManagerSim
//
//  Created by CCS038 on 08/09/26.
//

import Foundation
import SwiftUI

struct DownloadListView: View {
    @State private var viewModel = DownloadManagerViewModel()
    var body: some View {
        
        NavigationStack {
            Group {
                if viewModel.downloads.isEmpty {
                    ContentUnavailableView("No Downloads", systemImage: "tray", description: Text("Tap the + button to queue a new file."))
                } else {
                    List {
                        ForEach(viewModel.downloads) { item in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.fileName)
                                    .font(.headline)
                                
                                HStack {
                                    Text(item.statusText)
                                    Spacer()
                                    Text("\(item.fileSize, specifier: "%.1f") MB")
                                    
                                    if let iconName = item.actionIconName {
                                        Button {
                                            viewModel.toggleDownload(for: item.id)
                                        } label: {
                                            Image(systemName: iconName)
                                        }
                                        .buttonStyle(.borderless)
                                    }
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                
                                if let progress = item.currentProgress {
                                    ProgressView(value: progress, total: 100)
                                }
                            }
                        }
                        .onDelete(perform: viewModel.deleteDownload)
                    }
                }
            }
            .navigationTitle("Downloads")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Resume All", systemImage: "play.circle") {
                            viewModel.resumeAll()
                        }
                        Button("Pause All", systemImage: "pause.circle") {
                            viewModel.pauseAll()
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    
                    Button {
                        viewModel.addRandomDownload()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
    }
}

#Preview {
    DownloadListView()
}
