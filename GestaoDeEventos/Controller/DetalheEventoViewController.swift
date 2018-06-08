//
//  DetalheEventoViewController.swift
//  GestaoDeEventos
//
//  Created by Israel3D on 08/06/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class DetalheEventoViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    var evento:Eventos!
    var participantes:[Participante] = []
    
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
        
        REST.returnParticipantes(idEvento: 2) { (participantes) in
            self.participantes = participantes
            DispatchQueue.main.async {
                self.tableViewParticipantes.reloadData()
            }
        }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participantes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let participante = participantes[indexPath.row]
        
        let cellIdentifier = "celulaReusoParticipante"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = participante.nome
        cell.detailTextLabel?.text = participante.checkIn ? "ChekIn EFETUADO" : "ChekIn NÃO EFETUADO"
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheParticipante" {
            if let indexPath = tableViewParticipantes.indexPathForSelectedRow{
                let participanteDetalhe = participantes[(indexPath.row)]
                let viewController = segue.destination as! DetalhesParticipanteViewController
                viewController.idParticipante = participanteDetalhe.id
            }
            
        }
    }
    

}
