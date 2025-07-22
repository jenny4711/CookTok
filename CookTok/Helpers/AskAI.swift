//
//  askAI.swift
//  CookTok
//
//  Created by Ji y LEE on 7/21/25.
//

import Combine
import FirebaseVertexAI
import FirebaseAI

class AskAI: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var geminiResponse: String?
    @Published var showAISummery: Bool = false
    
    private let model: GenerativeModel = VertexAI.vertexAI().generativeModel(modelName: "gemini-2.5-flash")
    
    func newRecipe(ingredients: [Items]) async {
        await getRecipe(ingredients)
    }
}

extension AskAI {
    func getRecipe(_ ingredients: [Items]) async {
        await MainActor.run {
            self.isLoading = true
            self.geminiResponse = "Gemini가 생각 중입니다..."
        }

        do {
            // 재료 이름들을 문자열로 변환
            let ingredientNames = ingredients.compactMap { $0.itemName }.joined(separator: ", ")
            
            let prompt = """
            냉장고에 있는 재료: \(ingredientNames)
            
            이 재료들로 만들 수 있는 난이도 는 초급 수준 으로 맛있는 레시피 2개정도 알려주세요. 
            참고로 ** 나 ## 같은 특수 문자는 작성하지 마세요
            다음 형식으로 답변해주세요:
            
            [요리명]
            재료: (필요한 재료와 양)
            조리시간: (예상 시간)
            난이도: (초급/중급/고급)
            
            조리방법:
            1. (첫 번째 단계)
            2. (두 번째 단계)
            ...
            
            팁: (조리 팁이나 주의사항)
            """
            
            let response = try await model.generateContent(prompt)

            await MainActor.run {
                if let text = response.text {
                    self.geminiResponse = text
                    print(text)
                  // self.showAISummery = true  // 응답을 받으면 시트 표시
                } else {
                    self.geminiResponse = "응답이 없습니다."
                }
            }
        } catch {
            await MainActor.run {
                self.geminiResponse = "오류 발생"
                print(error.localizedDescription)
            }
            print("Gemini API 호출 오류: \(error)")
        }

        await MainActor.run {
            self.isLoading = false
        }
    }
    
    func checkRes(){
        
    }
    
}
