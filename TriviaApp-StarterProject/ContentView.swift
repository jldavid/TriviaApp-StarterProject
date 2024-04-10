import SwiftUI

struct ContentView: View {
    
    @State private var questions = [Questions]()
    @State private var question = ""
    @State private var answers = [String]()
    @State private var correctAnswer = ""
    @State private var isPresented = false
    @State private var showQuiz = false
    @State private var rightAnswer = false
    
    var body: some View {
        VStack(alignment: .center) {
            if showQuiz {
                // Add UI code here
                Text("Add UI code here")
            } else {
                Text("Loading quiz...")
            }
        }
        .task {
            await loadData()
        }
        .alert(isPresented: $isPresented, content: {
            if rightAnswer {
                Alert(title: Text("You're right!"), message: Text("\(correctAnswer) is the correct answer."), dismissButton: .default(Text("Done")))
            } else {
                Alert(title: Text("Sorry, you're incorrect!"), message: Text("\(correctAnswer) is the correct answer."), dismissButton: .default(Text("Done")))
            }
        })
    }
    
    func checkAnswer(answer: String) {
        // Quiz logic here
    }
    
    func loadData() async {
        guard let url = URL(string: "") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Questions].self, from: data) {
                dump(decodedResponse)
                questions = decodedResponse
                // Populate your session variables here
                showQuiz = true
            } else {
                print("Could not decode the models. Check that your variables are correct!")
            }
        } catch {
            print("Invalid data")
        }
    }
}

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}

#Preview {
    ContentView()
}
