import SwiftUI

struct ExpireDateView: View {
    @Binding var expiryDate: Date
    @State private var showDatePickerSheet: Bool = false
    
    // ✅ 추가: TextField에 표시될 문자열 형태의 날짜를 위한 @State 변수
    @State private var expiryDateString: String = ""

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }

    var body: some View {
        VStack {
            TextField("유통기한", text: $expiryDateString) // ✅ 이 부분을 수정!
                .textFieldStyle(.roundedBorder)
                .onTapGesture {
                    showDatePickerSheet = true
                }
                .disabled(true) // 직접 입력은 막고 탭 제스처만 활성화
        }
        // ✅ onAppear와 onChange를 사용하여 expiryDate를 expiryDateString으로 동기화
        .onAppear {
            expiryDateString = dateFormatter.string(from: expiryDate)
        }
        .onChange(of: expiryDate) { newDate in
            expiryDateString = dateFormatter.string(from: newDate)
        }
        .sheet(isPresented: $showDatePickerSheet) {
            VStack {
                HStack {
                    Spacer()
                    Button("완료") {
                        showDatePickerSheet = false
                    }
                    .padding()
                }
                DatePicker(
                    "유통기한 선택",
                    selection: $expiryDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                Spacer()
            }
        }
    }
}

// --- Preview Provider ---
struct ExpireDateView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var previewExpiryDate: Date = Date()

        var body: some View {
            NavigationView {
                Form {
                    ExpireDateView(expiryDate: $previewExpiryDate)
                }
                .navigationTitle("Preview Expire Date")
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
