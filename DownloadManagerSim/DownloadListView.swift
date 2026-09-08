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

/*
        NavigationStack -> .navigationTitle("Downloads")
            |
          List
            |
             -- VStack(alignment: .leading)
*/
        
        NavigationStack {
            List(viewModel.downloads) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.fileName)
                        .font(.headline)
                    
                    HStack {
                        Text(item.statusText)
                        Spacer()
                        Text("\(item.fileSize, specifier: "%.1f") MB")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    if let progress = item.currentProgress {
                        ProgressView(value: progress, total: 100)
                    }
                }
            }
            .navigationTitle("Downloads")
        }
        
    }
}

#Preview {
    DownloadListView()
}
