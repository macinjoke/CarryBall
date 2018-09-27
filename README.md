# CarryBall

ボールを運ぶ2Dパズルアクションゲーム。Processingで開発。

![carry_ball_demo](https://cloud.githubusercontent.com/assets/10493229/23090538/8a1027c2-f5e3-11e6-844b-25c4b0fcbc17.gif)

# 概要
マウスクリックでボールを生成し、合致する番号のエリアにボールを導くゲーム。
さらにキーボード操作で自機(赤いボール) を動かすことができる。

生成できるボールの上限はステージごとに決まっている。

跳ねる床、跳ねない床、軽いボール、重いボールなどが用意されている。

# 環境

Processing3.01

# 動かし方

https://processing.org/download/?processing
公式サイトからProcessing3系を落としてきて、起動する。

`git clone https://github.com/tonkatu05/CarryBall.git`
で好きな場所にソースコードを落とす。

ProcessingからCarryBall/hoge.pdeを開く。
すると、CarryBallディレクトリ直下の.pdeファイルがタブで全て開かれる。

実行ボタンを押すとゲームが起動する。

# どうやって作ったか
運動量保存の法則とか空気抵抗などの物理演算を自分でコーディングしたり、オブジェクト(障害物やボール) の配置を座標指定で手動で配置したり泥臭いことをやって作った。
一応オブジェクト指向しているが、4年前(2014年)に作ったものなのでちょっとコーディングが荒い。
