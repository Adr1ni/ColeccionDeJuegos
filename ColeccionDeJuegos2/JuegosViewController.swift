//
//  JuegosViewController.swift
//  ColeccionDeJuegos2
//
//  Created by Adriano on 6/05/24.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    var imagePicker =  UIImagePickerController()
    var juego :Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if juego != nil{
            imageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
    }
    
    

    @IBAction func camaraTapped(_ sender: Any) {
    }
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true,completion: nil)
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil{
            juego!.titulo = tituloTextField.text
            juego!.imagen =  imageView.image?.jpegData(compressionQuality: 0.50)
        }else{
            let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen =  imageView.image?.jpegData(compressionQuality: 0.50)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada  = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
}
