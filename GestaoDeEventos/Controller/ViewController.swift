//
//  ViewController.swift
//  GestaoDeEventos
//
//  Created by Israel3D on 06/06/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableViewEventos: UITableView!
    var activityIndicator = UIActivityIndicatorView()
    var eventos:[Eventos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewEventos.dataSource = self
        tableViewEventos.delegate = self
        
        carregando()
        
        REST.returnEvento(idCliente: -1) { (eventos) in
            self.eventos = eventos
            DispatchQueue.main.async {
                self.pararCarregando()
                self.tableViewEventos.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let evento = eventos[indexPath.row]
        
        let cellIdentifier = "celulaReuso"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventosCelula
        
        cell.lblNomeEvento.text = evento.nome
        cell.lblLocalEvento.text = evento.local
        cell.data.text = evento.inicio
        cell.imagem.image = evento.imagem
        cell.clienteImagem.image = evento.clienteImagem
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheEvento" {
            if let indexPath = tableViewEventos.indexPathForSelectedRow{
                let eventosDetalhe = self.eventos[(indexPath.row)]
                let viewController = segue.destination as! DetalheEventoViewController
                viewController.evento = eventosDetalhe
            }
            
        }
    }
    
    func carregando() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func pararCarregando(){
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

