//import UIKit
//
//class TestsViewController: UIViewController {
//
//    let label = UILabel()
//    let imageView = UIImageView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        label.text = "Constraint finder"
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)
//        view.addSubview(imageView)
//
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        //label.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
//        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        label.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
//
//        imageView.backgroundColor = UIColor.systemRed
//        imageView.isUserInteractionEnabled = true
//        //imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
//        imageView.widthAnchor.constraint(equalTo: label.widthAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
//
//        imageView.topAnchor.constraintEqualToAnchor(anchor: view.topAnchor, constant: 50, identifier: "imageViewTopAnchor")?.isActive = true
//        //imageView.topAnchor.constraintEqualToAnchor(anchor: self.topAnchor, constant:100, identifier:"ticketTop").active = true
//
//
//        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
//        imageView.addGestureRecognizer(touchGesture)
//
//        print("Label's top achor constraints: \(label.constraints(on: label.topAnchor))")
//        print("Label's left achor constraints: \(label.constraints(on: label.leftAnchor))")
//        print("Label's bottom achor constraints: \(label.constraints(on: label.bottomAnchor))")
//        print("Label's right achor constraints: \(label.constraints(on: label.rightAnchor))")
//
//        print("Label's width achor constraints: \(label.constraints(on: label.widthAnchor))")
//        print("ImageView's top achor constraints: \(imageView.constraints(on: imageView.topAnchor))")
//
//    }
//
//    @objc func tapped(_ sender: UITapGestureRecognizer) {
//        if sender.state == .ended {
//            print("was touched")
//            //let cnst = imageView.constraints(on: imageView.topAnchor)[0]
//            //cnst.isActive = false
//            imageView.constraint(withIdentifier: "imageTopViewAnchor")?.isActive = false
//            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100).isActive = true
//            //print("first anchor: \(cnst.firstAnchor)")
//            //print("second anchor:\(cnst.secondAnchor)")
//            //cnst.constant = 200
//            //imageView.constraint(withIdentifier: "imageViewTopAnchor")?.constant
//            //cnst.isActive = true
//            UIView.animate(withDuration: 0.5) {
//                super.view.layoutIfNeeded()
//            }
//
//
//        }
//    }
//
//}
