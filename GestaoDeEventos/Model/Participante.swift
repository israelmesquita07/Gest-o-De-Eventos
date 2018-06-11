//
//  Participante.swift
//  GestaoDeEventos
//
//  Created by Israel3D on 07/06/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class Participante {
    
    var id: Int!
    var nome: String!
    var email: String?
    var assinatura: UIImage?
    var dataCadastro: String!
    var checkIn: Bool!
    
    
    init(id: Int, nome: String, email: String, assinatura: UIImage, dataCadastro: String!, checkIn: Bool) {
        self.id = id
        self.nome = nome
        self.email = email
        self.assinatura = assinatura 
        self.dataCadastro = dataCadastro
        self.checkIn = checkIn
    }
    
}
