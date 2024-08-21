import SwiftUI

struct EditGeulView: View {
    @Binding var geul: GeulInfo  // 선택된 글귀의 바인딩
    
    var body: some View {
        Form {
            TextField("Title", text: $geul.title)
            TextField("Name", text: $geul.name)
            TextEditor(text: $geul.content)
        }
        .navigationTitle("Edit Geul")
    }
}
