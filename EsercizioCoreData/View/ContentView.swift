//
//  ContentView.swift
//  EsercizioCoreData
//
//  Created by Michele on 17/01/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var gestione = Gestione()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Post.entity(), sortDescriptors: [NSSortDescriptor(key: "data", ascending: true)], animation: .spring()) var results : FetchedResults<Post>
    @State var image : Data = .init(count : 0)
    var body: some View {
        NavigationView{
            ZStack {
                Color.gray.opacity(0.16).ignoresSafeArea(.all, edges: .all)
                VStack {
                    ScrollView{
                            ForEach(results){ risultato in
                                VStack(alignment:.leading){
                                    Image(uiImage: UIImage(data: risultato.foto ?? image)!)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width:UIScreen.main.bounds.width - 34, height:210)
                                    .cornerRadius(6)
                                    .padding(.top)
                                    .padding(.leading,10)
                                    .padding(.trailing,10)
                                    
                                    HStack{
                                        
                                        Text("\(risultato.desc ?? "")")
                                            .padding(.leading)
                                            Spacer(minLength: 0)
                                        Button(action: {
                                            risultato.piaciuto.toggle()
                                            try! viewContext.save()
                                        }, label: {
                                            
                                            Image(systemName: risultato.piaciuto  ?  "hand.thumbsup.fill" : "hand.thumbsup")
                                            
                                        }).padding(.trailing)
                                        
                                    }
                                    Text(risultato.titolo ?? "")
                                        .padding(.leading)
                                        .padding(.top,10)
                                        .padding(.bottom,10)
                                }
                                .background(Color.white)
                                .padding(.top,10)
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(action: {
//                                        Modifica
                                        
                                        gestione.Modfica(posti: risultato)
                                    }, label: {
                                        Text("Modifica")
                                    })
                                    Button(action: {
//                                      Elimina
                                        viewContext.delete(risultato)
                                        try! viewContext.save()
                                    }, label: {
                                        Text("Elimina")
                                    })
                                }))
                            }
                        }
                    
                    }
                .navigationBarTitle(Text("Ricordi"),displayMode: .inline)
                .navigationBarItems(trailing:
                        Button(action: {
                            self.gestione.mostraInserimento.toggle()
                        }, label: {
                    Text("Add")
                        })
            )
            }
        }
        .sheet(isPresented: $gestione.mostraInserimento, content: {
            AggiungiView().environmentObject(gestione).environment(\.managedObjectContext, self.viewContext)
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
