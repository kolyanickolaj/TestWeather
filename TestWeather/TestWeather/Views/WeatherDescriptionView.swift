//
//  WeatherDescriptionView.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import SwiftUI

struct WeatherDescriptionView: View {
    @State var title: String
    @Binding var description: String
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(description)
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    WeatherDescriptionView(title: "Humidity", description: .constant("\(13)"))
}
