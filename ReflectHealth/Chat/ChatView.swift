//
//  ChatView.swift
//  ReflectHealth
//
//  Created by Martin on 10/08/2024.
//

import SwiftUI
import MarkdownUI

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                    messageView(message: message)
                }
            }
            HStack {
                TextField("Enter a message...", text: $viewModel.currentInput)
                Button {
                    viewModel.sendMessage()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.title)
                        .disabled(viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                
            }
        }
        .padding()
    }
    

    @ViewBuilder
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user { Spacer() }
            Markdown(message.content)
                .padding()
                .background(message.role == .assistant ? .pink.opacity(0.3) : .blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            if message.role == .assistant { Spacer() }
        }
    }
    

}

#Preview {
    ChatView()
}
