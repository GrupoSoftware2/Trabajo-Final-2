//
//  DetalleViewController.swift
//  Trabajo Final 2
//
//  Created by Rocío Córdova on 25/03/17.
//  Copyright © 2017 José Romero. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {
    
    var objeto: Item!
    
    @IBOutlet weak var img: UIImageView!
    
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    
    @IBOutlet weak var precio: UILabel!
    
    
    @IBOutlet weak var controlador: UIPageControl!
    
    
    var tiempo : Timer!
    
    var contador : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.text = objeto.nombre
        desc.text = objeto.desc
        precio.text = "S/.\(objeto.precio!)"
        
        contador = 0
        
        tiempo = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DetalleViewController.actualizar), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func actualizar(){
        if(contador <= 2){
            controlador.currentPage = contador
            
            switch contador {
            case 0:
                img.image = objeto.img1
            case 1:
                img.image = objeto.img2
            default:
                img.image = objeto.img3
            }
            contador = contador + 1
        }else{
            contador = 0
        }
        
    }

    
    @IBAction func comprar(_ sender: UIButton) {
      
        if !añadirCarrito.contains(objeto) {
            
            let alerta = UIAlertController(title: "¡Alerta!", message: "El producto se añadio al carrito",preferredStyle: UIAlertControllerStyle.alert)
            let accionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle .default, handler: nil)
            
            alerta.addAction(accionOK)
            self.present(alerta, animated: true, completion: nil)
            
            añadirCarrito.append(objeto)
        }
        
    }
    
    
}
