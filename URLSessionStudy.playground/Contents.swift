import UIKit

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
    task.resume()
}

//解説
//URLSession.sharedとは -
//URLSessionのインスタンスを作る際に、設定情報を渡す必要があります。
//URLSession.sharedを使うと、設定情報なしで、セッションが使えます。（インスタンス化なしで使える）





