//
//  TableViewController.swift
//  SalesRanking1
//
//  Created by tichinose1 on 2018/04/01.
//  Copyright © 2018年 example.com. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var items = [
        Result(name: "モンスターストライク", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Purple128/v4/d7/3a/ae/d73aae7d-b2c0-998f-c7a1-a2f60215b880/AppIcon-1x_U007emarketing-85-220-7.png/200x200bb.png"),
        Result(name: "パズル＆ドラゴンズ", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/c3/97/35/c397356b-bf5f-cae6-724f-5dc638a17f6c/AppIcon-1x_U007emarketing-0-85-220-0-9.png/200x200bb.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sales Ranking"
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-grossing/all/30/non-explicit.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            let item = try! JSONDecoder().decode(Item.self, from: data!)
            self.items = item.feed.results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = item.name
        
        let url = URL(string: item.artworkUrl100)!
        let data: Data = try! Data(contentsOf: url)
        let image = UIImage(data: data)
        cell.imageView?.image = image

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
