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
    var pagina = 1, totalPaginas = 1, registrosPagina = 10
    
    @IBOutlet weak var lblNomeEvento: UILabel!
    @IBOutlet weak var lblLocalEvento: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tableViewParticipantes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewParticipantes.dataSource = self
        tableViewParticipantes.delegate = self
        
        self.lblNomeEvento.text = evento.nome
        self.lblLocalEvento.text = evento.local
        self.lblData.text = evento.inicio
        self.image.image = evento.imagem
        
        returnParticipantes(pagina: pagina)
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participantes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let participante = participantes[indexPath.row]
        
        let cellIdentifier = "celulaReusoParticipante"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = participante.nome
        
        if participante.checkIn {
            cell.detailTextLabel?.text =  "ChekIn EFETUADO"
            cell.backgroundColor = UIColor.yellow
        } else {
            cell.detailTextLabel?.text = "ChekIn NÃO EFETUADO"
        }
        
        return cell
    }
    

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableViewParticipantes {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                pagina+=1
                if !(pagina > totalPaginas){
                    returnParticipantes(pagina: pagina)
                }
            }else {
                pagina-=1
                if (pagina > 0){
                    returnParticipantes(pagina: pagina)
                }
            }
        }
    }

    func returnParticipantes(pagina:Int){
        REST.returnParticipantes(idEvento: evento.id, pagina: pagina, totalPaginas: totalPaginas, registrosPorPagina: registrosPagina) { (participantes, pagina, totalPaginas, registrosPagina) in
            self.participantes = participantes
            self.pagina = pagina
            self.totalPaginas = totalPaginas
            self.registrosPagina = registrosPagina
            DispatchQueue.main.async {
                self.tableViewParticipantes.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheParticipante" {
            if let indexPath = tableViewParticipantes.indexPathForSelectedRow{
                let participanteDetalhe = participantes[(indexPath.row)]
                print(participanteDetalhe.id)
                let viewController = segue.destination as! DetalhesParticipanteViewController
                viewController.idParticipante = participanteDetalhe.id
            }
            
        }
    }
    

}
