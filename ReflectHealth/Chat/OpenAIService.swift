//
//  OpenAIService.swift
//  ReflectHealth
//
//  Created by Martin on 10/08/2024.
//

import Foundation
import Alamofire

class OpenAIService {
    
    private let endpointURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let openAIMessages = messages.map({ OpenAIChatMessage(role: $0.role, content: $0.content) })
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIApiKey)"
        ]
        
        let body = OpenAIChatBody(model: "gpt-4o-mini", messages: openAIMessages)
        
        do {
            let response = try await AF.request(endpointURL, method: .post, parameters: body, encoder: .json, headers: headers).serializingString().value
            print("Raw API Response: \(response)")  // Print raw response for debugging
            
            if let jsonData = response.data(using: .utf8) {
                let decodedResponse = try JSONDecoder().decode(OpenAIChatResponse.self, from: jsonData)
                return decodedResponse
            } else {
                print("Failed to convert response to Data")
                return nil
            }
        } catch {
            print("API Request failed with error: \(error)")
            return nil
        }
    }}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
