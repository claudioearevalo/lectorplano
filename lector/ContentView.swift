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
    
    @State private var versionApp = "Lector 1.0"
    @State private var archivoAeditar = ""
    @State private var mensaje = "None"
    @State private var contenidoDelarchivo = ""
    @State private var resultado:URL?
    
    private let tipoDearchivos = ["txt", "md", "csv"]
    
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
                    cajaDedialogo.message = NSLocalizedString("lector-caja-dialogo-key", comment: "")
                    cajaDedialogo.showsResizeIndicator = true
                    cajaDedialogo.allowsMultipleSelection = false
                    cajaDedialogo.canChooseDirectories = false
                    cajaDedialogo.allowedFileTypes = tipoDearchivos
                    if cajaDedialogo.runModal() == .OK {
                        resultado = cajaDedialogo.url
                        //Self.ubicacionDelarchivo = String(resultado!)
                        
                        if resultado != nil
                        {
                            do {
                                try contenidoDelarchivo = String(data: Data(contentsOf: resultado!), encoding: .utf8)!
                                    archivoAeditar = " - " + cajaDedialogo.url!.lastPathComponent
                                
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

                        if (contenidoDelarchivo != "" && resultado != nil) {
                            grabarContenido()
                        }
                        else
                        {
                            //si no hay nombre hay que darle nombre
                            let cajaDedialogograbar = NSSavePanel()
                            cajaDedialogograbar.message = NSLocalizedString("lector-caja-dialogo-grabar-key", comment: "")
                            cajaDedialogograbar.nameFieldStringValue = "Nota"
                            cajaDedialogograbar.canCreateDirectories = true
                            cajaDedialogograbar.allowedFileTypes = tipoDearchivos
                            cajaDedialogograbar.begin { response in
                                if response == NSApplication.ModalResponse.OK, let archivoAsignado = cajaDedialogograbar.url {
                                    resultado = cajaDedialogograbar.url
                                    archivoAeditar = " - " + cajaDedialogograbar.url!.lastPathComponent
                                    grabarContenido()
                                }
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
                
        }.navigationTitle(versionApp + archivoAeditar)
    }
    
    func grabarContenido() {
        do {
            try contenidoDelarchivo.write(to: resultado!, atomically: true, encoding: String.Encoding.utf8)
                
        }
            catch {
                
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

