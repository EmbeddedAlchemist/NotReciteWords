import router from '@ohos.router'
@Entry
@Component
struct moreSetting {
  build() {

    Column() {
      Row() {
        Image($r("app.media.return")).width(15).margin({
          top: 35,
        }).onClick(() => {
          router.back()
        })
        Text("更多设置").fontSize(17).padding({
          top: 35,
          left: 151,
          bottom: 4
          // right:10
        }).fontWeight(600)
      }.backgroundColor(Color.White).width("100%")

      Scroll() {

        Column() {

          Column() {

            Text("帮助与反馈").fontSize(17).padding({
              top: 30,
              right: 212,
              bottom: 10
              // right:10
            }).fontWeight(600)


            Row() {
              Text("评价应用").fontSize(17).padding({
                top: 30,
                right: 168,
                bottom: 10
                // right:10
              }).fontWeight(600)
              Text("V5.8.10").fontColor("#908989").fontSize(15).padding({
                top: 30,
                right: 10,
                bottom: 10
                // right:10
              }).fontWeight(600)
            }

            Text("推荐给好友").fontSize(17).padding({
              top: 30,
              right: 214,
              bottom: 10
              // right:10
            }).fontWeight(600)


          }.backgroundColor(Color.White).width("100%")

          Column() {

            Text("服务条款").fontSize(17).padding({
              top: 30,
              right: 231,
              bottom: 10
              // right:10
            }).fontWeight(600)


            Text("隐私协议及简明版").fontSize(17).padding({
              top: 30,
              right: 163,
              bottom: 10
              // right:10
            }).fontWeight(600)

            Text("儿童信息保护").fontSize(17).padding({
              top: 30,
              right: 196,
              bottom: 10
              // right:10
            }).fontWeight(600)


            Text("个人信息收集清单").fontSize(17).padding({
              top: 30,
              right: 162,
              bottom: 10
              // right:10
            }).fontWeight(600)

            Text("第三方数据共享").fontSize(17).padding({
              top: 30,
              right: 180,
              bottom: 10
              // right:10
            }).fontWeight(600)

            Text("应用权限管理").fontSize(17).padding({
              top: 30,
              right: 197,
              bottom: 10
              // right:10
            }).fontWeight(600)

            Text("个性化推荐").fontSize(17).padding({
              top: 30,
              right: 214,
              bottom: 10
              // right:10
            }).fontWeight(600)

            Text("学习模式").fontSize(17).padding({
              top: 30,
              right: 231,
              bottom: 30
              // right:10
            }).fontWeight(600)


          }.backgroundColor(Color.White).width("100%").margin({
            top: 10
          })

          Column() {


            Row() {
              Text("清除缓存").fontSize(17).padding({
                top: 30,
                right: 189,
                bottom: 10
                // right:10
              }).fontWeight(600)
              Text("2MB").fontColor("#908989").fontSize(15).padding({
                top: 30,
                right: 10,
                bottom: 10
                // right:10
              }).fontWeight(600)
            }

            Text("注销账号").fontSize(17).padding({
              top: 30,
              right: 231,
              bottom: 30
              // right:10
            }).fontWeight(600)


          }.backgroundColor(Color.White).width("100%").margin({
            top: 10
          })

          Text("ID:27721006").margin({
            top: 40
          }).fontColor("#908989")


        }.backgroundColor('#fff1f3f5').margin({
          bottom: 100
        })

      }.scrollable(ScrollDirection.Vertical).width("100%").height("100%").backgroundColor('#fff1f3f5')

    }

  }
}