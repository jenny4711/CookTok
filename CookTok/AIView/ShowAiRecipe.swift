//
//  ShowAiRecipe.swift
//  CookTok
//
//  Created by Ji y LEE on 7/21/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct ShowAiRecipe: View {
    @StateObject private var askAI = AskAI()
    let aiResponse:String?
    @Query private var items:[Items]

    var body: some View {
        VStack(spacing: 0) {
           Text("AI RECIPE")
            .font(Font.bold25)
            .foregroundColor(Color.customBlue)
            .padding(.bottom,10)
            .padding(.top,20)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let response = aiResponse {
//                            Text(response)
                          FormattedRecipeText(text: response ?? "")
                                .foregroundColor(.black)
                        } else {
                            Text("레시피를 불러오는 중...")
                                .foregroundColor(.gray)
                                .italic()
                        }
                    }
                    .padding(20)
                }
            }
            .padding()
        }
        .background(Color.customSkyBlue)
       
    }
}

// 레시피 텍스트 포맷팅 컴포넌트
struct FormattedRecipeText: View {
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            let sections = parseRecipeText(text)
            
            ForEach(Array(sections.enumerated()), id: \.offset) { index, section in
                VStack(alignment: .leading, spacing: 8) {
                    switch section.type {
                    case .title:
                        Text(section.content)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.bottom, 8)
                        
                    case .subtitle:
                        Text(section.content)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                        
                    case .content:
                        Text(section.content)
                            .font(.body)
                            .lineSpacing(4)
                        
                    case .list:
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(Array(section.content.components(separatedBy: "\n").enumerated()), id: \.offset) { _, item in
                                if !item.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    HStack(alignment: .top, spacing: 8) {
//                                        Text("•")
//                                            .foregroundColor(.blue)
                                        Text(item.trimmingCharacters(in: .whitespacesAndNewlines))
                                            .font(.body)
                                    }
                                }
                            }
                        }
                        
                    case .numberedList:
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(Array(section.content.components(separatedBy: "\n").enumerated()), id: \.offset) { index, item in
                                if !item.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    HStack(alignment: .top, spacing: 8) {
//                                        Text("\(index + 1).")
//                                            .font(.body)
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.blue)
//                                            .frame(width: 25, alignment: .leading)
                                        Text(item.trimmingCharacters(in: .whitespacesAndNewlines))
                                            .font(.body)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 12)
                
            }
        }
    }
    
    private func parseRecipeText(_ text: String) -> [RecipeSection] {
        var sections: [RecipeSection] = []
        let lines = text.components(separatedBy: .newlines)
        var currentSection: RecipeSection?
        var currentContent = ""
        
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedLine.isEmpty {
                if let section = currentSection {
                    sections.append(section)
                    currentSection = nil
                    currentContent = ""
                }
                continue
            }
            
            // 제목 감지 (대괄호로 둘러싸인 텍스트)
            if trimmedLine.hasPrefix("[") && trimmedLine.hasSuffix("]") {
                if let section = currentSection {
                    sections.append(section)
                }
                let title = String(trimmedLine.dropFirst().dropLast())
                currentSection = RecipeSection(type: .title, content: title)
                continue
            }
            
            // 부제목 감지 (콜론으로 끝나는 텍스트)
            if trimmedLine.hasSuffix(":") && !trimmedLine.contains("조리방법") && !trimmedLine.contains("팁") {
                if let section = currentSection {
                    sections.append(section)
                }
                let subtitle = String(trimmedLine.dropLast())
                currentSection = RecipeSection(type: .subtitle, content: subtitle)
                continue
            }
            
            // 조리방법 섹션
            if trimmedLine.contains("조리방법:") {
                if let section = currentSection {
                    sections.append(section)
                }
                currentSection = RecipeSection(type: .subtitle, content: "조리방법")
                continue
            }
            
            // 팁 섹션
            if trimmedLine.contains("팁:") {
                if let section = currentSection {
                    sections.append(section)
                }
                currentSection = RecipeSection(type: .subtitle, content: "팁")
                continue
            }
            
            // 번호가 매겨진 리스트 감지 (숫자. 로 시작)
            if trimmedLine.range(of: #"^\d+\."#, options: .regularExpression) != nil {
                if currentSection?.type == .numberedList {
                    currentContent += "\n" + trimmedLine
                    currentSection = RecipeSection(type: .numberedList, content: currentContent)
                } else {
                    if let section = currentSection {
                        sections.append(section)
                    }
                    currentSection = RecipeSection(type: .numberedList, content: trimmedLine)
                    currentContent = trimmedLine
                }
                continue
            }
            
            // 글머리 기호 리스트 감지 (* 또는 - 로 시작)
            if trimmedLine.hasPrefix("*") || trimmedLine.hasPrefix("-") {
                if currentSection?.type == .list {
                    currentContent += "\n" + trimmedLine
                    currentSection = RecipeSection(type: .list, content: currentContent)
                } else {
                    if let section = currentSection {
                        sections.append(section)
                    }
                    currentSection = RecipeSection(type: .list, content: trimmedLine)
                    currentContent = trimmedLine
                }
                continue
            }
            
            // 일반 텍스트
            if let section = currentSection {
                if section.type == .list || section.type == .numberedList {
                    currentContent += "\n" + trimmedLine
                    currentSection = RecipeSection(type: section.type, content: currentContent)
                } else {
                    currentContent += (currentContent.isEmpty ? "" : "\n") + trimmedLine
                    currentSection = RecipeSection(type: .content, content: currentContent)
                }
            } else {
                currentSection = RecipeSection(type: .content, content: trimmedLine)
                currentContent = trimmedLine
            }
        }
        
        if let section = currentSection {
            sections.append(section)
        }
        
        return sections
    }
}

// 레시피 섹션 타입
enum RecipeSectionType {
    case title
    case subtitle
    case content
    case list
    case numberedList
}

// 레시피 섹션 구조체
struct RecipeSection {
    let type: RecipeSectionType
    let content: String
}

#Preview {
    ShowAiRecipe(aiResponse: """
    [요리명] 연어 스테이크와 부드러운 오트밀크 스크램블 에그

    재료:
    *   연어 필레: 1조각 (약 150-200g)
    *   계란: 2-3개
    *   오트밀크: 2-3 큰술

    조리방법:
    1.  재료 준비: 연어 필레는 키친타월로 물기를 제거
    2.  연어 굽기: 팬에 올리브 오일을 두르고 중강불로 달굽니다

    팁:
    *   연어: 연어를 구울 때 껍질 부분을 충분히 바삭하게 익히면 더욱 맛있습니다
    *   스크램블 에그: 오트밀크를 넣으면 계란이 더욱 부드러워집니다
    """)
}
