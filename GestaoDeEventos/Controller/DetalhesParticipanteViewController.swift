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
    @IBOutlet weak var txtNomeParticipante: UITextField!
    @IBOutlet weak var txtEmailParticipante: UITextField!
    @IBOutlet weak var txtDataCadastro: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
