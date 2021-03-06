## コードレビュー

### MainServer::Site

* `opt_detect_by_urlopt`をdetectするのに`opt`を渡してもらうのが分かりにくい。素直に`params`を渡してもらえば、他にもoptionやsiteなどのパラメータと併せて確認するなど、ロジックが複雑になった場合にも対応できる。「url文字列とパラメータから、optを自動判別するメソッド」なのか「url文字列からoptを自動判別するが、optが先に分かっていればそちらを優先するメソッド」なのかの違い。どうしても後者でやりたいなら、`op`t引数はいっそ外しても良いと思う。

* `set`で、netpriceの設定値は余力があれば`application.yml`に追い出した方がスッキリする。`cp_map`の近くに。

* `cp?`は`!np?`という話を思い出して。

* `SiteError`使ってない？せっかく定義したなら、`exists_site`で使う。使わないなら消す。

### MainServer::Cookies

* `law_member_id`？もしかしてraw？

* `favorite`を完全に消した？`Biz::Favorite::Cookies`の方に全部移したのは、ダメではないけど。「favoriteのリストを、配列として扱う（cookieにどんな文字列で格納されているかは、外に意識させない）」のは`Cookies`の役目。「favoriteのリストを、ユーザの操作やビジネス制限にあわせて操作する」のは`Favorite::Cookies`の役割って最初の設計で、良かった感じがする。

* 削除の時、少なくとも現行では「valueは意味の無い文字列に、expiresは1970.1.1」とかじゃなかったかな？敢えて変えたのには理由が？「`value`エントリが無いと無視するブラウザがいる」とか「ユーザ端末の時計が2時間ズレてて残っちゃう」とか（実際にあるのかは知らないけど）危険性が増す想像はできるけど、良くなる方の想像は出来ない。理由が無いなら、実績のある方法に揃えた方がいいんじゃない？

* specで、`favorite`の削除と併せてテストをコメントアウトしちゃってるけど、`favorite`を最終的にどういう実装にしようと、ここで「`site`が未確定状態でアクセスすることを禁じるべき値では、その場合にちゃんとエラーが起きる」というテストはしておくべき。その逆に「`site`が未確定でも、関係無い値にはアクセス可能である」ということも。

### Biz::Favorite

* `add`で、既に入っている商品が再度登録されようとしている場合、正しい動きは「無視」ではなく「その商品を先頭に持ってくる」のような気がする。

* `add`で「50個を超えていた場合は末尾をひとつ削除」というのは、正しいけど危うい挙動。おかしなことになっているcookieや、途中で制限値が変わった場合などを考えると「制限値を超えていた場合は制限内の値まででカット」とかにした方が、強い。`shift(50)`とかを用いた方が良いかと。

* やっぱり`join('--')`とか`split('--')`が頻繁に出てきて気持ち悪い。`MainServer::Cookies`の方に持っていくか、せめてこのクラス内で処理をまとめた方が。

* 前回も言ったけど、やっぱり引数指定に括弧の有無が混在していて気持ち悪い。自分は「右辺にある場合は括弧を付ける。そうでなければ付けない」としているけど、強いてコードから類推するとその逆のルールにしてるのかな？とにかく、ちゃんとしたルールを決めて則って。

* `set`で`nil`が入ってきた時「何もしない」というのは正しい動き？「消したいなら`clear`を使え」という理屈はとにかく、指定されたならそのまま入れた方が良いんじゃ。

### Biz::Db

* まだ作ってる途中だけど、必須実装のメソッドは出来る限り`Biz::Favorite`と順番を揃えて。ダックタイピングはコーダーが頑張って実装すべきメソッドを知らないといけないので、しっかりガイドを。自信が無ければ、ダックタイピングの考え方は捨てて（擬似）抽象クラスを継承させるのも手。

* `get`の処理が冗長な感じ。32-36行目は、多分 `fav_data.map{|g| g[:goods_id].to_s}` の一行で書ける（最終的にはto_sも不要になりそうだけど）

* きっちり読み切れてないけど、追加時の「重複禁止」や「制限数」などの処理、入ってる？model側でやっていればいいけど。

* ついでにというか。SQL見たらfind_allで順番の指定とかも無さそう。根本的に配列の順番って無関係？その場合、個数制限ひっかかったら、どこからアウトさせる？DBなら無制限？仕様次第で、しっかり実装を。
