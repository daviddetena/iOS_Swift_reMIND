//
//  IconsViewController.swift
//  reMIND
//
//  Created by David de Tena on 25/02/2017.
//  Copyright © 2017 David de Tena. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class IconsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    var iconList : [[String : String]] = [[String : String]]()
    var headerTitleString : String?
    var selectedTask : Int?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.title
        
        // Initialize array of icons
        iconList.append(["icon":"img_icono_compra", "title":"Shopping"])
        iconList.append(["icon":"img_icono_economia", "title":"Finances"])
        iconList.append(["icon":"img_icono_amor", "title":"Love"])
        iconList.append(["icon":"img_icono_amigos", "title":"Friends"])
        iconList.append(["icon":"img_icono_lugares", "title":"Places"])
        iconList.append(["icon":"img_icono_fechas", "title":"Dates"])
        iconList.append(["icon":"img_icono_webs", "title":"Webs"])
        iconList.append(["icon":"img_icono_archivos", "title":"Compra"])
        iconList.append(["icon":"img_icono_musica", "title":"Music"])
        iconList.append(["icon":"img_icono_vacaciones", "title":"Holidays"])
        iconList.append(["icon":"img_icono_ideas", "title":"Ideas"])
        iconList.append(["icon":"img_icono_deportes", "title":"Sports"])
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        let icon = iconList[indexPath.row]
        
        if let cell = cell as? IconCell {
            if let icon = icon["icon"] {
                cell.icon.image = UIImage(named: icon)
            }
            
            if let title = icon["title"]{
                cell.title.text = title
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        
        headerView.taskName.text = headerTitleString
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // We want the selected icon to be the icon of the selected task in the previous screen
        let icon = iconList[indexPath.row]
        if let selectedTask = selectedTask {
            TaskManager.sharedInstance.tasks[selectedTask]["icon"] = icon["icon"]
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Force the collection view to include three elements per row
        let maxScreenWidth = collectionView.frame.size.width/3.5
        return CGSize(width: maxScreenWidth, height: maxScreenWidth)
    }
}
