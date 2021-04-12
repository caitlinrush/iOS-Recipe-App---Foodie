//
//  ProfileView.swift
//  Foodie
//
//  Created by Pallavi Singla on 2020-11-24.
//

import SwiftUI

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var image: UIImage?
    @State private var showSheet: Bool = false
    @State private var permissionGranted: Bool = false
    @State private var showPicker: Bool = false
    @State private var isUsingCamera: Bool = false
    
    var body: some View {
        VStack{
            Image(uiImage: image ?? UIImage(named: "placeholder")!)
                .resizable()
                .frame(width: 300, height: 300)
            Button(action:{
                if(permissionGranted){
                    self.showSheet = true}
                else{
                    self.requestPermissions()
                }
                //print(#function, "Upload button clicked")
            }){
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Upload Photo")
                        }
                .accentColor(Color.blue)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15)
                    .opacity(0.2))
                .cornerRadius(5.0)
            }
            .actionSheet(isPresented: $showSheet){
                ActionSheet(title: Text("Select Photo"),
                            message: Text("Choose the photo to upload"),
                            buttons: [.default(Text("Choose from Photo Library")){
                                self.showPicker = true
                               
                            },
                            .default(Text("Take a new picture from camera")){
                                self.isUsingCamera = true
                                self.showPicker = true
                            },
                            .cancel()
                            ])
            }
            .navigationBarTitle("Profile View")
        }.fullScreenCover(isPresented: $showPicker){
            //TODO open picker
            if(isUsingCamera){
                CameraPicker(image: self.$image, isPresented: $isUsingCamera)
            } else{
                LibraryPicker(selectedImage: self.$image, isPresented: self.$showPicker)
            }
        }
        .onAppear{
            self.checkPermissions()
        }
    }
    
    private func checkPermissions(){
        switch PHPhotoLibrary.authorizationStatus(){
        case .authorized:
            self.permissionGranted = true
        case .notDetermined:
            return
        case .denied:
            return
        case .restricted:
            return
        case .limited:
            break
        @unknown default:
            break
            
        }
    }
    
    private func requestPermissions(){
        PHPhotoLibrary.requestAuthorization{ status in
            switch status{
            case .authorized:
                self.permissionGranted = true
            case .notDetermined:
                return
            case .denied:
                return
            case .restricted:
                return
            case .limited:
                return
            @unknown default:
                return
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
