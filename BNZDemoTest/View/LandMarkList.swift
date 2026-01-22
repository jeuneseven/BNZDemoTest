//
//  LandMarkList.swift
//  BNZDemoTest
//
//  Created by seven on 2026/1/22.
//

import SwiftUI

struct LandMarkList: View {
    @State private var listViewModel = LandMarkViewModel()
        
    var body: some View {
        NavigationStack {
            Group {
                switch listViewModel.state {
                case .idle, .loading:
                    loadingView
                case .loaded(let list):
                    loadedView(list)
                case .error(let error):
                    errorView(error)
                }
            }
            .navigationTitle(listViewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await listViewModel.fetch()
        }
    }
    
    // MARK: - Loading View
    private var loadingView: some View {
        VStack(spacing: listViewModel.loadingStackSpacing) {
            ProgressView()
                .scaleEffect(listViewModel.loadingProgressScale)
            Text(listViewModel.loadingMessage)
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Loaded View
    private func loadedView(_ list: [LandMark]) -> some View {
        List(list) { item in
            LandMarkRow(landmark: item)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .listRowSeparator(.visible)
                .accessibilityElement(children: .combine)
                .accessibilityHint(listViewModel.listItemAccessibilityHint)
        }
        .listStyle(.plain)
    }
    
    // MARK: - Error View
    private func errorView(_ error: String) -> some View {
        VStack(spacing: listViewModel.errorStackSpacing) {
            Image(systemName: listViewModel.errorImageName)
                .font(.system(size: listViewModel.errorImageSize))
                .foregroundStyle(.red)
            
            Text(listViewModel.errorTitle)
                .font(.headline)
            
            if !error.isEmpty {
                Text(error)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(listViewModel.retryButtonText) {
                Task {
                    await listViewModel.retry()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, listViewModel.retryButtonTopPadding)
        }
        .padding(listViewModel.errorViewPadding)
    }
}

#Preview {
    LandMarkList()
}
