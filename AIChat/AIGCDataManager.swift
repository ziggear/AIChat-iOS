//
//  AIGCDataManager.swift
//  AIChat
//
//  Created by ziggzhang on 2024/7/21.
//

import Foundation

class AIGCDataManager: ObservableObject {
    static let shared = AIGCDataManager()
    
    @Published var chats: [Chat] = []

    private let fileURL: URL

    private init() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = documentsPath.appendingPathComponent("chats.json")
        loadChats()
    }

    func addChat(name: String, platform: AIPlatform, apiKey: String) {
        let newChat = Chat(id: UUID(), name: name, platform: platform, apiKey: apiKey, messages: [])
        chats.append(newChat)
        saveChats()
    }

    func addMessage(to chatID: UUID, message: Message) {
        if let index = chats.firstIndex(where: { $0.id == chatID }) {
            chats[index].messages.append(message)
            saveChats()
        }
    }

    private func saveChats() {
        do {
            let data = try JSONEncoder().encode(chats)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save chats: \(error.localizedDescription)")
        }
    }

    private func loadChats() {
        do {
            // Check if the file exists before attempting to read
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)
                
                // Decode data if it's not empty
                if !data.isEmpty {
                    chats = try JSONDecoder().decode([Chat].self, from: data)
                }
            } else {
                print("File does not exist. No data to load.")
            }
        } catch {
            print("Failed to load chats: \(error.localizedDescription)")
            // Optionally initialize with default or empty data
            chats = []
        }
    }
}
