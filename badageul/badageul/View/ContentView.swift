import SwiftUI

struct GeulInfo: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var name: String
    var category: Category
    
    struct Category: Equatable, Identifiable {
        var id: String { name }
        var name: String
        var color: Color
        
        // 미리 정의된 카테고리 색상 및 이름
        static let all = Category(name: "전체보기", color: Color.gray.opacity(0.2))
        static let book = Category(name: "책", color: Color("yellow"))
        static let lyrics = Category(name: "노래", color: Color("orange"))
        static let quote = Category(name: "명언", color: Color("green"))
        
        static let allCategories: [Category] = [.all, .book, .lyrics, .quote]
    }
}

struct ContentView: View {
    @State private var geul = [
        GeulInfo(title: "", content: "참된 행복은 절제에서 솟아난다.", name: "괴테", category: .quote),
        GeulInfo(title: "싯다르타", content: "지식은 아는 것이고, 지혜는 행동하는 것이다.", name: "헤르만 헤세", category: .book),
        GeulInfo(title: "아틀란티스 소녀", content: "저 먼 바다 끝엔 뭐가 있을까 다른 무언가 세상과는 먼 얘기 구름위로 올라가면 보일까 천사와 나팔부는 아이들 숲속 어디엔가 귀를 대보면 오직 내게만 작게 들려오는 목소리 꿈을 꾸는 듯이 날아가볼까 저기 높은 곳 아무도 없는 세계", name: "", category: .lyrics)
    ]
    
    @State private var searchText = ""  // 검색어를 저장하는 상태 변수
    @State private var selectedCategory: GeulInfo.Category = .all  // 기본값으로 "전체보기" 카테고리 선택
    
    @State private var showingDeleteAlert = false
    @State private var itemToDelete: IndexSet?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Text("오늘의 글귀")
                    .font(Font.custom("GowunDodum-Regular", size: 30))
                Spacer()
                
                // 검색 필드 추가 (심볼 및 피커 포함)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("글귀를 검색해주세요..", text: $searchText)
                        .padding(10)
                    
                    // 카테고리 선택 버튼
                    Menu {
                        ForEach(GeulInfo.Category.allCategories) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Label(category.name, systemImage: "")
                                    .foregroundColor(category.color)
                            }
                        }
                    } label: {
                        Circle()
                            .fill(selectedCategory.color)
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                
                List {
                    // 검색어와 선택된 카테고리에 따라 필터링된 결과 표시
                    ForEach(filteredGeul) { geulItem in
                        NavigationLink(destination: EditGeulView(geul: Binding.constant(geulItem))) {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .fill(geulItem.category.color)
                                    .frame(width: 25)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(geulItem.content)
                                        .font(.body)
                                        .padding(.top, 10)
                                    
                                    if geulItem.category == .book || geulItem.category == .lyrics {
                                        Text("-\(geulItem.title)")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 10)
                                    } else if geulItem.category == .quote {
                                        Text("-\(geulItem.name)")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 10)
                                    }
                                }
                                .padding(.leading, 10)
                                
                                Spacer()
                            }
                            .background(Color.white)
                            .border(Color.gray, width: 1)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete { offsets in
                        itemToDelete = offsets
                        showingDeleteAlert = true
                    }
                    .padding(10)
                }

                .listStyle(PlainListStyle())
                .alert(isPresented: $showingDeleteAlert) {
                    Alert(
                        title: Text("삭제 확인"),
                        message: Text("정말로 이 글귀를 삭제하시겠습니까?"),
                        primaryButton: .destructive(Text("삭제")) {
                            if let itemToDelete = itemToDelete {
                                geul.remove(atOffsets: itemToDelete)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                Spacer()
                
                NavigationLink(destination: AddGeulView(geul: $geul)) {
                    Image("Group 18").resizable().scaledToFit().frame(width: 85).padding(.leading, 240)
                }
            }
            
        }
    }
    
    // 필터링된 글 리스트 반환
    var filteredGeul: [GeulInfo] {
        geul.filter { geulItem in
            (searchText.isEmpty || geulItem.title.contains(searchText) || geulItem.content.contains(searchText) || geulItem.name.contains(searchText)) &&
            (selectedCategory == .all || geulItem.category == selectedCategory)
        }
    }
}

#Preview {
    ContentView()
}
