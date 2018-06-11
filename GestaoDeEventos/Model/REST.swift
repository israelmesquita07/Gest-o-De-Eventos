//
//  REST.swift
//  GestaoDeEventos
//
//  Created by Israel3D on 07/06/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class REST {
    
    //GET /Evento/EventosAtivosDoCliente
    class func returnEvento(idCliente:Int = -1, onComplete: @escaping([Eventos]) -> Void) {
        
        if let url = URL(string: "http://receptivawebapi.azurewebsites.net/api/Evento/EventosAtivosDoCliente?idCliente=\(idCliente)") {
            
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (dataRtd, response, error) in
                
                if error == nil {
                    
                    if let data = dataRtd {
                        do {
                            
                            if let objJson = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
                                var event:[String:Any] = [:]
                                var eventos:[Eventos] = []
                                var i = 0
                                while objJson.count > i {
                                    event = (objJson[i] as? [String:Any])!
                                    let imagem = try? Data(contentsOf: URL(string:(event["Imagem"] as? String)!)!)
                                    let clienteImagem = try? Data(contentsOf: URL(string:(event["ClienteImagem"] as? String)!)!)
                                    
                                    let evento = Eventos(id: event["Id"] as! Int, nome: event["Nome"] as! String, imagem: UIImage(data:imagem!)! , clienteImagem: UIImage(data:clienteImagem!)! , inicio: event["Quando"] as! String, local: event["Local"] as! String)
                                    
                                    eventos.append(evento)
                                    i+=1
                                }
                                onComplete(eventos)
                            }

                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }else{
                    print(error?.localizedDescription as Any)
                }
            })
            dataTask.resume()
        }
    }
    
    // POST /Evento/ParticipantesDoEvento
    class func returnParticipantes(idEvento:Int, pagina:Int, totalPaginas:Int, registrosPorPagina:Int, onComplete: @escaping([Participante], Int, Int, Int) -> Void) {
        
        let params = ["Pagina":"\(pagina)", "RegistrosPorPagina":"\(registrosPorPagina)"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "http://receptivawebapi.azurewebsites.net/api/Evento/ParticipantesDoEvento?idEvento=\(idEvento)")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let dataTask = URLSession.shared.dataTask(with: request) { (dataRtd, response, error) in
            
            if error == nil {
                if let data = dataRtd {
                    do {
                        let objJson = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
                        var part:[String:Any] = [:]
                        var participantes:[Participante] = []
                        let pagina = objJson["Paginador"]!["Pagina"] as! Int
                        let totalPaginas = objJson["Paginador"]!["TotalPaginas"] as! Int
                        let registrosPagina = objJson["Paginador"]!["RegistrosPorPagina"] as! Int
                        
                        if let participes = objJson["Lista"] as? NSArray {
                            var i = 0
                            while participes.count > i {
                                
                                part = (participes[i] as? [String:Any])!
                                print(objJson as Any)
                                let chekIn = (part["CheckIn"] as? String != nil) ? true : false
                                let participante = Participante(id: part["Id"] as! Int, nome: part["Nome"] as! String, email: "", assinatura: UIImage(), dataCadastro: "", checkIn: chekIn)
                                
                                participantes.append(participante)
                                i+=1
                            }
                            
                        }
                        
                        onComplete(participantes, pagina, totalPaginas, registrosPagina)
                        
                    } catch {
                        print("error")
                    }
                }
            }else{
                print(error?.localizedDescription as Any)
            }
            
        }
        dataTask.resume()
    }
    
    // GET / Participante/ObterParticipante
    class func returnParticipante(idParticipante:Int = -1, onComplete: @escaping(Participante) -> Void) {
        
        if let url = URL(string: "http://receptivawebapi.azurewebsites.net/api/Participante/ObterParticipante?idParticipante=\(idParticipante)") {
            
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (dataRtd, response, error) in
                
                if error == nil {
                    
                    if let data = dataRtd {
                        do {
                            let objJson = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
                            
                            let chekIn = (objJson["CheckIn"] as? String != nil) ? true : false
                            let dateFormated = converterData(objJson["DataCadastro"] as! String)
                            var assinatura:UIImage!
                            
                            if(objJson["Assinatura"]! as? String != nil){
                                assinatura = UIImage(data:(Data(base64Encoded: (objJson["Assinatura"] as? String)!, options: Data.Base64DecodingOptions.ignoreUnknownCharacters))!)
                            }else{
                                assinatura = UIImage()
                            }
                            
                            let participante = Participante(id: objJson["Id"] as! Int, nome: objJson["Nome"] as! String, email: objJson["Email"] as? String ?? "", assinatura: assinatura ?? UIImage(), dataCadastro: dateFormated , checkIn: chekIn)
                            
                            onComplete(participante)
                            
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }else{
                    print(error?.localizedDescription as Any)
                }
            })
            dataTask.resume()
        }
    }
    
    class func converterData(_ data:String) -> String{
        let string = String(data.prefix(19))+"Z" // "2017-01-27T18:36:36Z"
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale
        return dateFormatter.string(from: date)
    }
    
    
}
