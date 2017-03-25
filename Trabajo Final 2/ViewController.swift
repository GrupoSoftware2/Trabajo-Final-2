//
//  ViewController.swift
//  Trabajo Final 2
//
//  Copyright © 2017 José Romero. All rights reserved.
//

import UIKit

private let reuseIdentifier = "colcell"
public var añadirCarrito = Array<Item>()
public var items = Array<Item>()

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchResultsUpdating {
    
    var itemsFiltrados = Array<Item>()
    
    var vwHeader:UIView!
    
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var vistaCollection: UICollectionView!
    
    @IBOutlet weak var vista: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...6 {
            let item = Item()
            item.nombre = "Item \(i)"
            item.desc = "Descripción del Item \(i)"
            item.precio = Double(i) * 100.0
            item.img1 = UIImage(named: "\(i)img1")
            item.img2 = UIImage(named: "\(i)img2")
            item.img3 = UIImage(named: "\(i)img3")
            
            items.append(item)
        }
        
        
        vwHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 50))
        searchController.searchBar.placeholder = "Búsqueda"
        searchController.searchResultsUpdater = self
        vwHeader = searchController.searchBar
        
        vista.addSubview(vwHeader)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let texto = searchController.searchBar.text
        
        itemsFiltrados = items.filter({ (item) -> Bool in
            
            return String(item.precio).lowercased().contains(texto!.lowercased()) || item.nombre.lowercased().contains(texto!.lowercased())
            
        })
        
        vistaCollection.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return itemsFiltrados.count
        }
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        let indice = indexPath.row
        let item:Item
        
    
        if  searchController.isActive && searchController.searchBar.text != "" {
            
            item = itemsFiltrados[indice]
        }else{
            
            item = items[indice]
        }
        
        
        celda.nombre.text = item.nombre
        celda.precio.text = "S/.\(item.precio!)"
        celda.img.image = item.img1
        
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGesture.minimumPressDuration = 1
        celda.addGestureRecognizer(longPressGesture)
    
        
        return celda
    }
    
    func longPress(sender: UILongPressGestureRecognizer){
        
        let celda = sender.view as! UICollectionViewCell
        
        let indexPath = vistaCollection?.indexPath(for: celda)
        let item = items[(indexPath?.row)!]
        
        
        if !añadirCarrito.contains(item) {
            
            let alerta = UIAlertController(title: "¡Alerta!", message: "El producto se añadio al carrito",preferredStyle: UIAlertControllerStyle.alert)
            let accionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle .default, handler: nil)
            
            alerta.addAction(accionOK)
            self.present(alerta, animated: true, completion: nil)
            
            añadirCarrito.append(item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let indice = indexPath.row
        let item = items[indice]
        
        
        self.performSegue(withIdentifier: "detalle", sender: item)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalle" {
            let enviar:DetalleViewController = segue.destination as! DetalleViewController
            
            
            enviar.objeto = sender as! Item
            
        }
        
    }
    
    
    @IBAction func carrito(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "carrito", sender: sender)
        
    }


}

