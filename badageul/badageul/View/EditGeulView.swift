import SwiftUI

struct EditGeulView: View {
    @Binding var path: NavigationPath
    
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
