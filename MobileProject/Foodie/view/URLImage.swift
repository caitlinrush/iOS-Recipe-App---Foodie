//
//  URLImage.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-11-23.
//

import SwiftUI

struct URLImage: View {
    let url: String
    let placeholder: String
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url: String, placeholder: String = "placeholder"){
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadImage(url: self.url)
    }
    var body: some View {
        if let data = self.imageLoader.downloadedData {
            return Image(uiImage: UIImage(data: data)!).renderingMode(.original).resizable()
        } else {
            return Image("placeholder").renderingMode(.original).resizable()
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "placeholder")
    }
}
