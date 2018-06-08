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
                                    
                                    let evento = Eventos(id: event["Id"] as! Int, nome: event["Nome"] as! String, imagem: UIImage(data:imagem!)!, clienteImagem: UIImage(data:clienteImagem!)!, inicio: event["Quando"] as! String, local: event["Local"] as! String)
                                    
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
    class func returnParticipantes(idEvento:Int, onComplete: @escaping([Participante]) -> Void) {
        
        let params = ["Pagina":"1", "RegistrosPorPagina":"1"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "http://receptivawebapi.azurewebsites.net/api/Evento/ParticipantesDoEvento?idEvento=\(idEvento)")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let dataTask = URLSession.shared.dataTask(with: request) { (dataRtd, response, error) in
            
            if error == nil {
                if let data = dataRtd {
                    print(response!)
                    do {
                        let objJson = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
                        
                        var participantes:[Participante] = []
                        var i = 0
                        while objJson.count > i {
                            let participes = objJson["Lista"]
                            let chekIn = (participes!["CheckIn"] != nil) ? true : false
                            
                            let participante = Participante(id: participes!["Id"] as! Int, nome: participes!["Nome"] as! String, email: "", assinatura: UIImage(), dataCadastro: "", checkIn: chekIn)
                            
                            participantes.append(participante)
                            
                            i+=1
                        }
                        onComplete(participantes)
                        
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
                            
                            if let objJson = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
                                var participes:[String:Any] = [:]
                                var participante: Participante!
                                var i = 0
                                while objJson.count > i {
                                    
                                    participes = (objJson[i] as? [String:Any])!
                                    
                                    let assinatura = try? Data(contentsOf: URL(string:(participes["Assinatura"] as? String)!)!)
                                    let chekIn = (participes["CheckIn"] != nil) ? true : false
                                    
                                    participante = Participante(id: participes["Id"] as! Int, nome: participes["Nome"] as! String, email: participes["Email"] as! String, assinatura: UIImage(data:assinatura!)!, dataCadastro: participes["DataCadastro"] as! String, checkIn: chekIn)
                                    i+=1
                                }
                                onComplete(participante)
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
    
}
