//
//  ChatView.swift
//  AIChat
//
//  Created by ziggzhang on 2024/7/21.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var dataManager = AIGCDataManager.shared
    let chat: Chat

    @State private var inputText: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(chat.messages) { message in
                    HStack {
                        if message.isUser {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(message.content)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                Text(message.timestamp, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            VStack(alignment: .leading) {
                                Text(message.content)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                Text(message.timestamp, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    }
                }
            }
            HStack {
                TextField("Enter message", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    let userMessage = Message(id: UUID(), content: inputText, isUser: true, timestamp: Date())
                    dataManager.addMessage(to: chat.id, message: userMessage)
                    inputText = ""
                    
                    // Simulate AI response (replace with actual API call)
                    let aiResponse = Message(id: UUID(), content: "AI Response", isUser: false, timestamp: Date())
                    dataManager.addMessage(to: chat.id, message: aiResponse)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle(chat.platform.rawValue)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMessages = [
            Message(id: UUID(), content: "Hello!", isUser: true, timestamp: Date()),
            Message(id: UUID(), content: "Hi there!", isUser: false, timestamp: Date())
        ]
        let chat = Chat(id: UUID(), name: "Sample Chat", platform: .chatGPT, apiKey: "YourAPIKeyHere", messages: sampleMessages)
        ChatView(chat: chat)
    }
}

