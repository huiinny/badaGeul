import SwiftUI

struct ContentView: View {
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Spacer()
                
                Text("여기는 홈 입니다.")
                
                Spacer()
                
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
                    AddGeulView(path: $path)
                case "2":
                    EditGeulView(path: $path)
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
