import SwiftUI
import UIKit

struct GeulInfo: Identifiable {
    var id = UUID()
    var title = ""
    var content: String
    var name: String
    var category: Category
    
    struct Category: Equatable {
        var color: Color
        
        // 미리 정의된 카테고리 색상
        static let book = Category(color: Color("yellow"))
        static let lyrics = Category(color: Color("orange"))
        static let quote = Category(color: Color("green"))
    }
}

struct ContentView: View {
    
    @State var path = NavigationPath()
    
    @State private var geul = [
        GeulInfo(content: "참된 행복은 절제에서 솟아난다.", name: "괴테", category: .quote),
        GeulInfo(content: "지식은 아는 것이고, 지혜는 행동하는 것이다.", name: "싯다르타", category: .book),
        GeulInfo(content: "저 먼 바다 끝엔 뭐가 있을까 다른 무언가 세상과는 먼 얘기 구름위로 올라가면 보일까 천사와 나팔부는 아이들 숲속 어디엔가 귀를 대보면 오직 내게만 작게 들려오는 목소리 꿈을 꾸는 듯이 날아가볼까 저기 높은 곳 아무도 없는 세계", name: "아틀란티스 소녀", category: .lyrics)
    ]
    
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Spacer()
                
                Text("오늘의 글귀")
                    .font(Font.custom("GowunDodum-Regular", size: 30))
                    
                
                Spacer()
                
                List {
                    ForEach(geul) { geul in
                        HStack(spacing: 0){
                            Rectangle()
                                .fill(geul.category.color)
                                .frame(width: 25)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(geul.content)
                                    .font(.body)
                                    .padding(.top, 10)
                                
                                Text("-\(geul.name)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 10)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                        
                        .background(Color.white) // 항목 자체의 배경을 설정
                        .border(Color.gray, width: 1)  // 테두리 추가
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.white) // 구분선 제거를 위한 배경 설정
                        
                    }
                    .padding(10)
                }
                .listStyle(PlainListStyle())  // 기본 리스트 스타일 유지
                
                Button {
                    path.append("2")
                } label: {
                    Text("글 수정")
                }
                
                Spacer()
                
                Button {
                    path.append("1")
                } label: {
                    Text("글 추가")
                }
                
                Spacer()
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "1":
                    AddGeulView(path: $path, geul: $geul)
                case "2":
                    EditGeulView(path: $path, geul: $geul)
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
