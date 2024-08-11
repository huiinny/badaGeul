import SwiftUI

struct AddGeulView: View {
    @Binding var path: NavigationPath
    @Binding var geul: [GeulInfo]  // 상위 뷰로부터 전달된 글 리스트에 바인딩

    @State private var selectedCategory: GeulInfo.Category? = nil
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var content: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("카테고리")
                .font(.headline)
            
            HStack(spacing: 20) {
                Button(action: {
                    selectedCategory = .book
                }) {
                    Text("책")
                        .padding()
                        .background(selectedCategory == .book ? Color.gray.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                
                Button(action: {
                    selectedCategory = .lyrics
                }) {
                    Text("노래")
                        .padding()
                        .background(selectedCategory == .lyrics ? Color.gray.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                
                Button(action: {
                    selectedCategory = .quote
                }) {
                    Text("명언")
                        .padding()
                        .background(selectedCategory == .quote ? Color.gray.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("제목")
                    .font(.headline)
                
                TextField("제목을 입력하세요", text: $title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("작가")
                    .font(.headline)
                
                TextField("작가를 입력하세요", text: $name)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("내용")
                    .font(.headline)
                
                TextEditor(text: $content)
                    .padding()
                    .frame(height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                if let selectedCategory = selectedCategory {
                    let newGeul = GeulInfo(content: content, name: name, category: selectedCategory)
                    geul.append(newGeul)  // 새로운 글을 리스트에 추가
                    path.removeLast()  // 현재 뷰를 닫고 이전 화면으로 돌아감
                }
            }) {
                Text("등록하기")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("글 추가")
    }
}
