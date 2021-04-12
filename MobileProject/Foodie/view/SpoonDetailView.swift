//
//  SpoonDetailView.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-12-09.
//

import SwiftUI

struct SpoonDetailView: View {
    @ObservedObject var spoonStore = SpoonStore()
    @State var id: Int
    
    var body: some View {
        NavigationView{
            if (spoonStore.details.count != 0){
                List(spoonStore.details){ detail in
                    VStack(alignment: .leading, spacing: 20){
                        Text(detail.title)
                            .font(.headline)
                        Text(detail.summary)
                    }
                }
            }
        }.onAppear{
            spoonStore.getDetailFromAPI(id: id)
        }
    }
}

struct SpoonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpoonDetailView(id: 2)
    }
}
