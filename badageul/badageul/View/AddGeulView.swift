import SwiftUI

struct AddGeulView: View {
    @Binding var geul: [GeulInfo]  // 상위 뷰로부터 전달된 글 리스트에 바인딩
    
    @State private var selectedCategory: GeulInfo.Category? = nil
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var content: String = ""
    @Environment(\.presentationMode) var presentationMode  // 현재 뷰를 닫기 위해 사용

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            
            Text("카테고리")
                .font(.headline)
                .padding(.leading)
            
            HStack(spacing: 20) {
                Button(action: {
                    selectedCategory = .book
                }) {
                    Text("책")
                        .foregroundColor(.black)
                        .padding()
                        .background(selectedCategory == .book ? Color("yellow") : Color.clear)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(red: 0.48, green: 0.49, blue: 0.50), lineWidth: 1) // 테두리 색상 변경
                        )
                }
                
                Button(action: {
                    selectedCategory = .lyrics
                }) {
                    Text("노래")
                        .foregroundColor(.black)
                        .padding()
                        .background(selectedCategory == .lyrics ? Color("orange") : Color.clear)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(red: 0.48, green: 0.49, blue: 0.50), lineWidth: 1) // 테두리 색상 변경
                        )
                }
                
                Button(action: {
                    selectedCategory = .quote
                }) {
                    Text("명언")
                        .foregroundColor(.black)
                        .padding()
                        .background(selectedCategory == .quote ? Color("green") : Color.clear)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(red: 0.48, green: 0.49, blue: 0.50), lineWidth: 1) // 테두리 색상 변경
                        )
                }
            }
            .padding(.leading)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("제목")
                    .font(.headline)
                
                TextField("제목을 입력하세요", text: $title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 0.48, green: 0.49, blue: 0.50), lineWidth: 1) // 테두리 색상 변경
                    )
                
                Text(selectedCategory == .lyrics ? "가수" : "지은이")
                    .font(.headline)
                
                TextField(selectedCategory == .lyrics ? "가수를 입력하세요" : "지은이를 입력하세요", text: $name)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 0.48, green: 0.49, blue: 0.50), lineWidth: 1) // 테두리 색상 변경
                    )
                
                Text("내용")
                    .font(.headline)

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
                        .frame(height: 150)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.48, green: 0.49, blue: 0.50), lineWidth: 1) // 테두리 색상 변경
                        )
                    if content.isEmpty {
                        Text("내용을 입력하세요")
                            .foregroundColor(Color(UIColor.placeholderText)) // UIKit의 lightGray 색상 사용
                            .font(.system(size: 17)) // 폰트 크기를 17로 설정
                            .padding(.horizontal, 16)
                            .padding(.vertical, 13)
                    }


                }

                
            }
            .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    if let selectedCategory = selectedCategory {
                        let newGeul = GeulInfo(title: title, content: content, name: name, category: selectedCategory)
                        geul.append(newGeul)  // 새로운 글을 리스트에 추가
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("등록하기")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal, 25)  // 양옆 여백 추가
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(15)
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("글 추가")
    }
}
