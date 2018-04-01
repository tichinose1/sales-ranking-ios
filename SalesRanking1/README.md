# sales-ranking-ios

## アプリ概要

- App StoreのRSSフィードから取得したセールスランキングを表示する
- [RSS Generator](https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-grossing/all/30/non-explicit.json)

## プロジェクトの新規作成

- 略

## 設定

- オートサインをオフにする

## 実行してみる

- ラベルを置いてエミュレータで実行する

## 画面作成

- デフォルトのViewControllerではなくNavigationControllerを使う
- `IsInitialViewController`を設定する
- タイトルをセールスランキングにする
- 実行してみる

## プログラムコードから画面を操作する

- デフォルトのViewControllerを削除し、TableViewControllerを追加する
- swiftクラスとStoryboardを紐付ける
- コードからタイトルを変えてみる

```swift
title = "Sales Ranking"
```

## セル

- 固定のセルを表示する

### Storyboard

- Style: `Basic`
- Identifier: `itemCell`
- Accessory: `Disclosure Indicator`

### TableViewController

```swift
override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 20
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)

    // Configure the cell...

    return cell
}
```

## データモデル

- データ構造を定義して、固定データをリストに表示する

### Result

```swift
struct Result: Decodable {
    let name: String
    let artworkUrl100: String
}
```

### TableViewController

```swift
var items = [
    Result(name: "モンスターストライク", artworkUrl100: ""),
    Result(name: "パズル＆ドラゴンズ", artworkUrl100: "")
]

...

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return items.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
    cell.textLabel?.text = item.name
    return cell
}
```

## 画像の表示（省略可）

- `swift.jpg`を追加

### TableViewController

```
cell.imageView?.image = UIImage(named: "swift")
```

## 画像をURLから取得

### TableViewController

```swift
Result(name: "モンスターストライク", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Purple128/v4/d7/3a/ae/d73aae7d-b2c0-998f-c7a1-a2f60215b880/AppIcon-1x_U007emarketing-85-220-7.png/200x200bb.png"),
Result(name: "パズル＆ドラゴンズ", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/c3/97/35/c397356b-bf5f-cae6-724f-5dc638a17f6c/AppIcon-1x_U007emarketing-0-85-220-0-9.png/200x200bb.png")

let url = URL(string: item.artworkUrl100)!
let data: Data = try! Data(contentsOf: url)
let image = UIImage(data: data)
cell.imageView?.image = image
```

## RSSからデータを取得

### TableViewController

```swift
let url = URL(string: "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-grossing/all/30/non-explicit.json")!

URLSession.shared.dataTask(with: url) { data, response, error in
    dump(data)
}.resume()
```

## JSONをパース

### Result

```swift
struct Item: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let artworkUrl100: String
```

### TableViewController

```swift
let item = try! JSONDecoder().decode(Item.self, from: data!)
```

## 画面に表示

### TableViewController

```swift
self.items = item.feed.results

DispatchQueue.main.async {
    self.tableView.reloadData()
}
```

### info.plist

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
