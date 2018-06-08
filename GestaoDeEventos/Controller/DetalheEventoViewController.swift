//
//  DetalheEventoViewController.swift
//  GestaoDeEventos
//
//  Created by Israel3D on 08/06/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class DetalheEventoViewController: UIViewController {

    var evento:Eventos!
    
    @IBOutlet weak var lblNomeEvento: UILabel!
    @IBOutlet weak var lblLocalEvento: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tableViewParticipantes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblNomeEvento.text = evento.nome
        self.lblLocalEvento.text = evento.local
        self.lblData.text = evento.inicio
        self.image.image = evento.imagem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheParticipante" {
            if let indexPath = tableViewParticipantes.indexPathForSelectedRow{
                let participanteDetalhe = self.evento.id
                let viewController = segue.destination as! DetalhesParticipanteViewController
                viewController.idParticipante = participanteDetalhe
            }
            
        }
    }
    

}
