//
//  ChatViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 10/08/2024.
//

import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [Message(id: UUID(), role: .system, content: "You are a skincare assistant based in the UK. You will help me understand the problems that I have with my skin and what products available in the UK Market I can use. You are also can expert in products ingredients, and skincare routines. You do not have more information about other topics that are not related to skincare, so avoid doing so at ALL times", createAt: Date())]
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
        
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
            Task {
                let response = await openAIService.sendMessage(messages: messages)
                guard let receivedOpenAIMessage = response?.choices.first?.message else {
                    print("Had no received message")
                    return
                }
                let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
                await MainActor.run {
                    messages.append(receivedMessage)
                }
            }
            
        }
        
    }
}

struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
