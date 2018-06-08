//
//  Eventos.swift
//  GestaoDeEventos
//
//  Created by Israel3D on 07/06/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class Eventos {
    
    var id: Int!
    var nome: String!
    var imagem: UIImage!
    var clienteImagem: UIImage!
    var inicio: String!
    var local: String!
    
    init(id: Int, nome: String, imagem: UIImage, clienteImagem: UIImage, inicio: String, local: String) {
        self.id = id
        self.nome = nome
        self.imagem = imagem
        self.clienteImagem = clienteImagem
        self.inicio = inicio
        self.local = local
        
    }
    
    
}
