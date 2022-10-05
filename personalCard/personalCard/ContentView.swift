//
//  ContentView.swift
//  personalCard
//
//  Created by Andrei Romanciuc on 05.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(red: 0.20, green: 0.67, blue: 0.88)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Andrei")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 6)
                    )

                Text("Andrei Romanciuc")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("iOS Developer")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                
                Divider()
                
                InfoView(text: "+40 752 465 671", image: "phone.fill")
                
                InfoView(text: "andrei.romanciuc@gmail.com", image: "envelope.fill")
                
            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct InfoView: View {
    
    let text: String
    let image: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 50)
            .foregroundColor(.white)
            .overlay(
                HStack{
                    Image(systemName: image)
                        .foregroundColor(Color(red: 0.20, green: 0.67, blue: 0.88))
                    Text(text).foregroundColor(.black)
                    
                })
    }
}
