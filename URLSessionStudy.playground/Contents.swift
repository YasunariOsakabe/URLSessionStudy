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


