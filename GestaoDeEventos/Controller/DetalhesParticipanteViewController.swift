//
//  DetalhesParticipanteViewController.swift
//  GestaoDeEventos
//
//  Created by Israel3D on 08/06/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class DetalhesParticipanteViewController: UIViewController {

    var idParticipante:Int!
    var participanteDetalhe: Participante!
    
    @IBOutlet weak var txtNomeParticipante: UITextField!
    @IBOutlet weak var txtEmailParticipante: UITextField!
    @IBOutlet weak var txtDataCadastro: UITextField!
    @IBOutlet weak var assinaturaImg: UIImageView!
    @IBOutlet weak var swChekIn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        REST.returnParticipante(idParticipante: idParticipante) { (participante) in
            DispatchQueue.main.async {
                self.txtNomeParticipante.text = participante.nome
                self.txtDataCadastro.text = participante.dataCadastro
                self.txtEmailParticipante.text = participante.email
                self.assinaturaImg.image = participante.assinatura
                self.swChekIn.isOn = participante.checkIn ? true : false
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
