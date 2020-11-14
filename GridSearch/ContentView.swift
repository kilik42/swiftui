//
//  ContentView.swift
//  GridSearch
//
//  Created by marvin evins on 11/13/20.
//

import SwiftUI

struct RSS: Decodable{
    let feed: Feed
}

struct Feed: Decodable{
    let results: [Result]
}

struct Result: Decodable, Hashable{
    let copyright, name, artworkUrl100, releaseDate: String
}
class GridViewModel: ObservableObject {
    @Published var items = 0..<5
    
    @Published var results = [Result]()
    
    init(){
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
//            self.items = 0..<15
//        }
        
                    guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json")else{
                return
            }
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                guard let data = data else{return}
                do {
                    let rss = try JSONDecoder().decode(RSS.self, from:data)
                    print(rss)
                    self.results = rss.feed.results
                }catch  {
                    print("failed to decode: \(error)")
                    
                }
                }.resume()
    }
}

import KingfisherSwiftUI
struct ContentView: View {
    
    @ObservedObject var vm = GridViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top)
                    
                ], alignment: .leading, spacing: 16, content: /*@START_MENU_TOKEN@*/{
                    ForEach(vm.results, id:\.self){
                        app in
                    
                        VStack(alignment:.leading, spacing: 4){
                            
                            KFImage(URL(string: app.artworkUrl100)).resizable().scaledToFit().cornerRadius(22)
                            
                      
                            Text(app.name).font(.system(size: 10, weight: .semibold))
                            Text(app.releaseDate).font(.system(size: 9, weight: .regular))
                            Text(app.copyright).font(.system(size: 9, weight: .regular))
                            Spacer()
                    }
                      //  .padding(.horizontal)
                  //  .background(Color.red)
                    
                    }
                }).padding(.horizontal, 12)
            }.navigationTitle("Movie Search")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
