# 2014.05.12 (代々木)

## 例外処理

* を受け取るメソッドを持つクラスを作りなさい
  メソッド内では、数値を標準出力に整形して表示させるようにします。ただしその時、数値が3の倍数であれば例外を発生させなさい

* 上記例外を、呼び出し元でキャッチしなさい

* 呼び出し元の処理を、数値配列をループさせてメソッドを呼ぶように変えなさい
  この時、例外発生時にはその旨を標準出力に表示させます
  
  ~~~ruby
  [1,3,5,9,0,2,6].each do |num|
    FizzBuzz.exec num  # ここで例外発生時の処理を追加
  end
  ~~~

* メソッド内に、数値が5の倍数であった場合にも例外を発生させるよう処理を追加しなさい
  また、3の倍数であり5の倍数でもある場合には、更に異なった例外として処理しなさい

* 配列に文字列が入るなど、全く予期しないエラーが出る場合も考えられます。
  そのようなエラーはまた別に処理し、その場合はエラー内容を出力して処理を中断させなさい

  ~~~ruby
  [1,3,"x",9,0,2,6].each do |num|
    FizzBuzz.exec num  # "x"の際に発生するであろうエラー時には、処理を中断
  end
  ~~~

* 最終的に、メソッドは次のような結果を返してください
  
  ~~~ruby
  FizzBuzz.exec 1
  # => 1
  FizzBuzz.exec 2
  # => 2
  FizzBuzz.exec 3
  # => raise error of "FizzBuzz::Fizz"
  FizzBuzz.exec 4
  # => 4
  FizzBuzz.exec 5
  # => raise error of "FizzBuzz::Buzz"
  FizzBuzz.exec 15
  # => raise error of "FizzBuzz::FizzBuzz"
  ~~~

* 次のような配列を渡した結果
  
  ~~~ruby
  FizzBuzzTest [1,2,3,4,5,6,7,15]
  ~~~

  次のように出力されるテスト関数`FizzBuzzTest`を、`FizzBuzz.exec`を使って作りなさい

  ~~~
  "1"
  "2"
  "Fizz!"
  "4"
  "Buzz!"
  "6"
  "7"
  "FizzBuzz!"
  ~~~

  この時、次のような配列を渡すと、処理が中断されるようにします

  ~~~ruby
  FizzBuzzTest [1,2,3,"x",5,6,7,15]
  ~~~

## 処理の切り替え

インターフェースを揃えて、処理の内容を切り替えられるようにする仕組みを実装しなさい

* Hashの値にProcが入っている形で、処理を切り替えるようにする
  
  ~~~ruby
  cafe[:espresso].call(:large, 2)
  # => "エスプレッソのLサイズを2個つくります。"
  cafe[:latte].call(:small, 10)
  # => "カフェラテのSサイズを10個つくります。"
  cafe[:flattwhite].call(:medium, 1)
  # => "当店でフラットホワイトは、カフェラテになります。そちらでよろしいですか？"
  ~~~

* クラス・メソッドを切り替える形で、処理を切り替えるようにする
  
  ~~~ruby
  cafe.__send__(:espresso, :large, 2)
  cafe.__send__(:latte, :small, 10)
  cafe.__send__(:flattwhite, :medium, 1)
  ~~~

## 次回以降

* Validatorを動くようにして、現時点で必要になるルールを作成する

* Controllerに対するspecを定義する

* Cookieの処理など、Controllerの責任領域について検討を進める

* Loginを完成させ、次の処理に移る
