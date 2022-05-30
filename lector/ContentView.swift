//
//  ContentView.swift
//  lector
//
//  Created by Claudio Arevalo on 25/05/2022.
//

import SwiftUI
import Foundation


//determinamos el nombre del archivo


struct ContentView: View {
    

    @State private var mensaje = "None"
    @State private var contenidoDelarchivo = ""
    @State private var resultado:URL?
    
    var body: some View {
        VStack{
            HStack{
            Label("lector-nombreDelaapp-key", systemImage: "bolt.fill")
            .frame(width: 100, height: 50)
            .background(Color.yellow)
            .foregroundColor(Color.black)
            .cornerRadius(6)
            .padding()
                Button(role: .destructive, action:
                {

                    
                    let cajaDedialogo = NSOpenPanel()
                    cajaDedialogo.title = "lector-caja-dialogo-key"
                    cajaDedialogo.showsResizeIndicator = true
                    cajaDedialogo.allowsMultipleSelection = false
                    cajaDedialogo.canChooseDirectories = false
                    
                    cajaDedialogo.allowedContentTypes = [.plainText]
                    if cajaDedialogo.runModal() == .OK {
                        resultado = cajaDedialogo.url
                        //Self.ubicacionDelarchivo = String(resultado!)
                        
                        if resultado != nil
                        {
                            do {
                                try contenidoDelarchivo = String(data: Data(contentsOf: resultado!), encoding: .utf8)!
                            }
                            catch
                            {
                                
                            }
                        }
                        
                    }
                })
                {
                 Label("lector-archivo-key", systemImage: "folder.fill")
                }
                .frame(width: 100, height: 50)
                .aspectRatio(contentMode: .fill)
                .background(Color.yellow)
                .foregroundColor(Color.black)
                .cornerRadius(6)
                .padding()
                .buttonStyle(BorderlessButtonStyle())

                    Button(role: .destructive, action:
                    {

                        if contenidoDelarchivo != "" {
                        do {
                            try contenidoDelarchivo.write(to: resultado!, atomically: true, encoding: String.Encoding.utf8)
                        }
                            catch {
                                
                        }
                        }

                    })
                    {
                     Label("lector-grabar-key", systemImage: "square.and.arrow.down")
                    }
                    .frame(width: 100, height: 50)
                    .aspectRatio(contentMode: .fill)
                    .background(Color.yellow)
                    .foregroundColor(Color.black)
                    .cornerRadius(6)
                    .padding()
                    .buttonStyle(BorderlessButtonStyle())
            }
            TextEditor(text: $contenidoDelarchivo)
                .border(Color.orange, width: 2)
                .font(.system(size: 18))
                
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

