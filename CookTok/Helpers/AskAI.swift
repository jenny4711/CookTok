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
    
    private let model: GenerativeModel = VertexAI.vertexAI().generativeModel(modelName: "gemini-2.0-flash")
    
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
            사용 가능한 재료: \(ingredientNames)
            
            이 재료들 중에서 **가장 적합한 조합을 선택해서** \(randomStyleKR) 스타일의 맛있는 레시피 2개 만들어주세요.
            모든 재료를 사용할 필요는 없고, 가장 맛있고 간단한 조합을 선택해주세요.
                        참고로 ** 나 ## 같은 특수 문자는 작성하지 마세요
                        다음 형식으로 답변해주세요:
            
            형식:
            [요리명]
            재료: (선택한 재료와 양)
            시간: (분)
            조리법:
            1. (단계)
            2. (단계)
            팁: (간단한 팁)
            """
            
            let prompt = """
            Available ingredients: \(ingredientNames)
            
            Choose the **best combination** from these ingredients to create 2 delicious \(randomStyleENG) recipes.
            You don't need to use all ingredients - select the most suitable and tasty combination.
            Keep responses short and concise.
            
            Format:
            [Recipe Name]
            Ingredients: (selected ingredients with amounts)
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
