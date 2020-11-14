//
//  ContentView.swift
//  GridSearch
//
//  Created by marvin evins on 11/13/20.
//

import SwiftUI

class GridViewModel: ObservableObject {
    @Published var items = 0..<5
    
    init(){
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            self.items = 0..<15 
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = GridViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200))
                    
                ], spacing: 16, content: /*@START_MENU_TOKEN@*/{
                    ForEach(vm.items, id:\.self){
                        num in
                    
                        VStack(alignment:.leading){
                            Spacer()
                                .frame(width: 100, height: 100, alignment:.center).background(Color.blue)
                        Text("App Title").font(.system(size: 10, weight: .semibold))
                        Text("App Title").font(.system(size: 9, weight: .regular))
                        Text("Release Date").font(.system(size: 9, weight: .regular))
                    }
//                    .padding()
                    .background(Color.red)
                    
                    }
                }).padding(.horizontal, 12)
            }.navigationTitle("GRID SEARCH")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
