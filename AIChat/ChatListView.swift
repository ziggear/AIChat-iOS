//
//  ChatListView.swift
//  AIChat
//
//  Created by ziggzhang on 2024/7/21.
//

import SwiftUI

struct ChatListView: View {
    @ObservedObject var dataManager = AIGCDataManager.shared

    var body: some View {
        NavigationView {
            List {
                ForEach(dataManager.chats) { chat in
                    NavigationLink(destination: ChatView(chat: chat)) {
                        VStack(alignment: .leading) {
                            Text(chat.name)
                                .font(.headline)
                            if let lastMessage = chat.lastMessage {
                                Text(lastMessage.content)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                Text(lastMessage.timestamp, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                Text("No messages yet")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AISelectionView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
