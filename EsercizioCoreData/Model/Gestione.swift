//
//  Gestione.swift
//  EsercizioCoreData
//
//  Created by Michele on 17/01/21.
//

import Foundation
import UIKit
import CoreData
class Gestione: ObservableObject {
    @Published var image : Data = .init(count:0)
    @Published var descrizione : String = ""
    @Published var titolo : String = ""
    @Published var mostraInserimento : Bool = false
    @Published var post : Post!
    
    //aggiungere valorie
    func Save(contex : NSManagedObjectContext){
        if(post != nil){
//            Update
            post.foto = image
            post.desc = descrizione
            post.titolo = titolo
            try! contex.save()
            mostraInserimento.toggle()
        }
        else{
            let newPost = Post(context: contex)
            newPost.data = Date()
            newPost.foto = image
            newPost.desc = descrizione
            newPost.titolo = titolo
                newPost.piaciuto = false
            do {
                try contex.save()
                mostraInserimento.toggle()
            } catch  {
                print(error.localizedDescription)
            }
        }
        image = .init(count: 0)
        descrizione = ""
        titolo = ""
        
    }
    func Modfica(posti : Post) {
//        Salvare  valori
        self.image = posti.foto!
        self.descrizione = posti.desc!
        self.titolo = posti.titolo!
        self.post = posti
        mostraInserimento.toggle()
        
    }

    
    
}
