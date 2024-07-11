import router from '@ohos.router'
@Entry
@Component
struct studySetting {
  build() {

      Scroll() {
        Column() {
          Row() {
            Image($r("app.media.return")).width(15).margin({
              top: 10,
            }).onClick(() => {
              router.back()
            })
            Text("学习设置").fontSize(17).padding({
              top: 10,
              left: 151,
              bottom: 4
              // right:10
            }).fontWeight(600)
          }.backgroundColor(Color.White).width("100%")

          Column() {

            Row() {
              Text("每组学习单词量").fontSize(17).padding({
                top: 30,
                right: 149,
                bottom: 10
                // right:10
              }).fontWeight(600)
              Text("10个").fontColor("#908989").fontSize(15).padding({
                top: 20,
                right: 10,
                bottom: 10
                // right:10
              }).fontWeight(600)
            }

            Row() {
              Text("单词发音类型").fontSize(17).padding({
                top: 30,
                right: 166,
                bottom: 10
                // right:10
              }).fontWeight(600)
              Text("英式").fontColor("#908989").fontSize(15).padding({
                top: 30,
                right: 10,
                bottom: 10
                // right:10
              }).fontWeight(600)
            }

            Row() {
              Text("自动发音").fontSize(17).padding({
                top: 30,
                right: 170,
                bottom: 10
                // right:10
              }).fontWeight(600)
              Text("全部开启").fontColor("#908989").fontSize(15).padding({
                top: 30,
                right: 10,
                bottom: 10
                // right:10
              }).fontWeight(600)
            }

            Row() {
              Text("学习提醒").fontSize(17).padding({
                top: 30,
                right: 192,
                bottom: 30
                // right:10
              }).fontWeight(600)
              Text("20:30").fontColor("#908989").fontSize(15).padding({
                top: 30,
                right: 10,
                bottom: 30
                // right:10
              }).fontWeight(600)
            }

          }.backgroundColor(Color.White).width("100%")

          Column() {
            Row() {
              Text("听音选义题型").fontSize(17).padding({
                top: 30,
                right: 168,
                bottom: 10
                // right:10
              }).fontWeight(600)
              Image($r("app.media.button3")).width(40).margin({
                top: 17,
                right: 1
              })
            }

            Text("助记顺序").fontSize(17).padding({
              top: 30,
              right: 244,
              bottom: 10
              // right:10
            }).fontWeight(600)
            Row() {
              Text("拼写").fontSize(17).padding({
                top: 30,
                right: 193,
                bottom: 10
                // right:10
              }).fontWeight(600)
              Text("学完整组测").fontColor("#908989").fontSize(15).padding({
                top: 30,
                right: 10,
                bottom: 10
                // right:10
              }).fontWeight(600)
            }

            Row() {
              Text("混淆项辨析").fontSize(17).padding({
                top: 30,
                right: 189,
                bottom: 30
                // right:10
              }).fontWeight(600)
              Image($r("app.media.button2")).width(40)
            }
          }.backgroundColor(Color.White).width("100%").margin({
            top: 10
          })

          Column() {
            Row() {
              Text("学习模式").fontSize(17).padding({
                top: 30,
                right: 174,
                bottom: 30
                // right:10
              }).fontWeight(600)
              Text("丰富模式").fontColor("#908989").fontSize(15).padding({
                top: 30,
                right: 10,
                bottom: 30
                // right:10
              }).fontWeight(600)
            }

          }.backgroundColor(Color.White).width("100%").margin({
            top: 10
          })

          Column() {
            Text("同步学习数据").fontSize(17).padding({
              top: 30,
              right: 213,
              bottom: 30
              // right:10
            }).fontWeight(600)

          }.backgroundColor(Color.White).width("100%").margin({
            top: 10
          })

        }.backgroundColor('#fff1f3f5')
      }.scrollable(ScrollDirection.Vertical).width("100%").height("100%")


  }
}