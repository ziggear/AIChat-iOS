//
//  Model.swift
//  AIChat
//
//  Created by ziggzhang on 2024/7/21.
//

import Foundation

enum AIPlatform: String, CaseIterable, Identifiable, Codable {
    case chatGPT = "Chat GPT"
    case gemini = "Gemini"
    case custom = "Custom"

    var id: String { self.rawValue }
}

struct Chat: Identifiable, Codable {
    let id: UUID
    let name: String
    let platform: AIPlatform
    let apiKey: String // Add this property
    var messages: [Message]
    var lastMessage: Message? {
        messages.last
    }
}

struct Message: Identifiable, Codable {
    let id: UUID
    let content: String
    var isUser: Bool
    let timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id, content, isUser, timestamp
    }
}


