////
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
    
    func newRecipe(ingredients: [Items],lang:String) async {
        await getRecipe(ingredients,lang)
    }
}

extension AskAI {
    func getRecipe(_ ingredients: [Items],_ lang:String) async {
        let randomStyles = ["한식", "양식", "중식", "일식", "퓨전", "건강식", "간단요리", "고급요리"]
        let randomStylesENG = ["Korean", "Western", "Chinese", "Japanese", "Fusion", "Healthy", "Simple", "High-end"]
        let randomStyleKR = randomStyles.randomElement() ?? "한식"
        let randomStyleENG = randomStylesENG.randomElement() ?? "Korean"


        
        await MainActor.run {
            self.isLoading = true
            self.geminiResponse = "Gemini가 생각 중입니다..."
        }

        do {
            // 재료 이름들을 문자열로 변환
            let ingredientNames = ingredients.compactMap { $0.itemName }.joined(separator: ", ")
            
            let promptKR = """
            재료: \(ingredientNames)
            
             이 재료로 **\(randomStyleKR) 스타일**의 다양하고 창의적인 간단한 레시피 2개 만들어주세요. 
            매번 다른 스타일과 조리법을 사용해주세요. 응답은 간결하게.
            
            형식:
            [요리명]
            재료: (재료와 양)
            시간: (분)
            조리법:
            1. (단계)
            2. (단계)
            팁: (간단한 팁)
            """
            
            let prompt = """
            Ingredients: \(ingredientNames)
            
            Create 2 simple **\(randomStyleENG)** 
            recipes using these ingredients. 
            
            Format:
            [Recipe Name]
            Ingredients: (list with amounts)
            Time: (minutes)
            Steps:
            1. (step)
            2. (step)
            Tips: (brief tip)
            """
          
           print("lang-AI-\(lang)")
            
            var response = try await model.generateContent(prompt)
            if lang == "KOR"{
                response = try await model.generateContent(promptKR)
            }else{
                response = try await model.generateContent(prompt)
            }
            let responseText = response.text
          
            await MainActor.run {
                if let text = responseText {
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
    
    
    
}
