//
//  AggiungiView.swift
//  EsercizioCoreData
//
//  Created by Michele on 17/01/21.
//

import SwiftUI

struct AggiungiView: View {
//    Creazione delle variabili
    @EnvironmentObject var gestione : Gestione
    @Environment(\.managedObjectContext) var context
    @State var mostraImagePicker : Bool = false
    var body: some View {
        VStack {
            if(gestione.image.count == 0){
            Button(action: {
//                Image Picker
                self.mostraImagePicker.toggle()
            }, label: {
                Image(systemName:"photo.fill")
                    .font(.system(size: 55))
                    .foregroundColor(.blue)
            })
            }
            else{
                Button(action: {
    //                Image Picker
                    self.mostraImagePicker.toggle()
                }, label: {
                    Image(uiImage: UIImage(data: self.gestione.image)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(6)
                })
            }
            TextField("titolo", text: $gestione.titolo)
                .padding()
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(20)
                .padding(.trailing,5)
                .padding(.leading,5)
                .padding(.top)
            TextField("Descrizione", text: $gestione.descrizione)
                .padding()
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(20)
                .padding(.trailing,5)
                .padding(.leading,5)
                .padding(.top)
            Button(action: {
//                Salvataggio Valori
                gestione.Save(contex: context)
                
            }, label: {
                Text("Salva")
                    .font(.title2)
                    .foregroundColor(.white)
            })
            .padding()
            .background(Color(.orange))
            .cornerRadius(20)
            .padding(.top)
            .disabled(Disabilitato())
            .opacity(Disabilitato() ? 0.5 : 1)
        }
        .sheet(isPresented: $mostraImagePicker, content: {
            ImagePicker(mostra: $mostraImagePicker, image: $gestione.image)
        })
    }
    func Disabilitato() -> Bool {
        if((gestione.image.count == 0)||(gestione.titolo == "") || (gestione.descrizione == "")){
            return true
        }else{
            return false
        }
    }
}

struct AggiungiView_Previews: PreviewProvider {
  
    static var previews: some View {
        AggiungiView().environmentObject(Gestione())
    }
}
