import UIKit
import Foundation

var greeting = "Hello, playground"

//通信関係の学習

//手順
//1.HTTPリクエストを送る
//2.HTTPレスポンスが帰ってくる


//1.HTTPリクエストを作る
//URLRequestというクラスを使って、HTTPリクエストを作ってあげる

func searchGithubUser(query: String) {
    let url = URL(string: "https://api.github.com/search/users?q=" + query)!
    let request = URLRequest(url: url)
}

//URLRequestというクラスは、上記のurlオブジェクトを渡すと、下記のHTTPリクエストを生成してくれます。


//HTTPリクエスト(URLRepuestにて作成されるもの)
//GET / HTTP/1.1
//Host: qiita.com
//User-Agent: curl/7.54.0
//Accept: */*

//2.HTTPリクエストを投げる、その結果を受け取る
//リクエストを投げるにはURLSessionというクラスを使いましょう。


func searchGithubUser(query: String) {

    let url = URL(string: "https://api.github.com/search/users?q=" + query)!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         //ここにデータ受信後の処理を書く
    }
    task.resume() //URLSessionDataTaskはインスタンス化しただけだと実行されないので、resume()メソッドを使って実行します。
}

//解説
//URLSession.sharedとは -
//URLSessionのインスタンスを作る際に、設定情報を渡す必要があります。
//URLSession.sharedを使うと、設定情報なしで、セッションが使えます。（インスタンス化なしで使える）


//dataTask(with: request)とは

dataTask(with: request) { (data, response, error) in
         //ここにデータ受信後の処理を書く
    }
//↓
//定義
func dataTask(with request: URLRequest,
completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

//１つめの引数にHTTPリクエストオブジェクトを、
//２つめの引数に「completionHandler」というクロージャをとって、
//戻り値にURLSessionDataTaskオブジェクトを返すメソッドです。

//completionHandler(data, response, error)について
//completionHandlerは簡単に言うと、通信が終了した後の完了処理をするためのクロージャです。

//completionHandlerは３つの引数をとって、戻り値を返さないクロージャです。
//URLSessionは、サーバ通信が終わると、このcompletionHandlerを実行します。

//引数３つの役割を説明すると、
//Data?: サーバから返されたデータが入る（オプショナル）。
//URLResponse?: HTTPレスポンスが入る（オプショナル）。
//Error?: エラーが発生していた場合、エラーコードが入る（オプショナル）。　ErrorはHTTPのエラーコードとは違うので、注意。



//@escapingは「関数に引数として渡されたクロージャが、関数のスコープ外で保持される可能性があることを示す属性」

//戻り値のURLSessionDataTaskというのは、URLSessionが作ったタスクです。
//１セッションが複数の具体的なタスクを持って、あるデータをとって来ては何らかの処理を加えるというイメージ


//JSON Decodeのための構造体
struct User: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Item]

    struct Item: Codable {
        let login: String
        let id: Int
        let node_id: String
        let avatar_url: URL
        let gravatar_id: String?
        let url: URL
        let html_url: URL
        let followers_url: URL
        let subscriptions_url: URL
        let organizations_url: URL
        let repos_url: URL
        let received_events_url: URL
        let type: String
        let score: Double
    }
}

func searchGithubUser(query: String)  {
    //1)HTTPリクエストを作る
    let url = URL(string: "https://api.github.com/search/users?q=" + query)!
    let request = URLRequest(url: url)
    //2)HTTPリクエストを投げる
    let decoder: JSONDecoder = JSONDecoder()

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //データ受信後の処理
        guard let data = data else { return }
        do {
            let user: User = try decoder.decode(User.self, from: data)
            print(user)
        } catch let e {
            print("JSON Decode Error :\(e)")
            fatalError()
        }
    }
    //URLSessionDataTaskを実行
    task.resume()
}


