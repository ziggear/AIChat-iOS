//
//  AISelectionView.swift
//  AIChat
//
//  Created by ziggzhang on 2024/7/21.
//

import SwiftUI

struct AISelectionView: View {
    @ObservedObject var dataManager = AIGCDataManager.shared
    @Environment(\.presentationMode) var presentationMode

    @State private var chatName: String = ""
    @State private var selectedPlatform: AIPlatform = .chatGPT // Default to a valid platform
    @State private var apiKey: String = ""
    @State private var customAPIURL: String = ""
    @State private var isCustomPlatform: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextField("Enter Chat Name", text: $chatName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Picker("Select AI Platform", selection: $selectedPlatform) {
                    ForEach(AIPlatform.allCases) { platform in
                        Text(platform.rawValue).tag(platform)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)
                .onChange(of: selectedPlatform) { newValue in
                    // Update isCustomPlatform based on selected platform
                    isCustomPlatform = (newValue == .custom)
                }

                if isCustomPlatform {
                    TextField("Enter Custom API URL", text: $customAPIURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }

                TextField("Enter API Key", text: $apiKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .textInputAutocapitalization(.none) // Avoid auto-capitalization for API keys

                Button("Save") {
                    // Handle saving chat based on selection
                    if selectedPlatform == .custom {
                        // Handle custom API URL case
                        print("Custom API URL: \(customAPIURL)")
                        // Save or use custom API URL as needed
                    } else {
                        dataManager.addChat(name: chatName, platform: selectedPlatform, apiKey: apiKey)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.top)
        }
        .navigationTitle("Select AI Platform")
    }
}

struct AISelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AISelectionView()
    }
}
