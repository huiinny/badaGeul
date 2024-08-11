import SwiftUI

struct EditGeulView: View {
    @Binding var path: NavigationPath
    @Binding var geul: [GeulInfo]  // 상위 뷰로부터 전달된 글 리스트에 바인딩

    @State private var selectedCategory: GeulInfo.Category? = nil
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var content: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("여기는 글수정 입니다.")
            
            Spacer()
            
            Button {
                path.removeLast(path.count)
            } label: {
                Text("등록하기")
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
