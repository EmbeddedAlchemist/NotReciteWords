@Entry
@Component
export struct MySwiper {


  build() {
    Column() {
      Swiper() {
        Column() {
          Text("Where there is a will there is a way.")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          Text("有志者，事竟成")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)
        }.height("100%")
        .justifyContent(FlexAlign.Center)


        Column() {
          Text("Read, study and learn about everything imporant in your life.")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          Text("点点滴滴皆重要，处处学习是诀窍")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)
        }.height("100%")
        .justifyContent(FlexAlign.Center)

        Column() {
          Text("Action speak louder than words.")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          Text("行动胜于言语")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)
        }.height("100%")
        .justifyContent(FlexAlign.Center)

        Column(){
          Text("Take control of your own desting.")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          Text("命运掌握在自己手中")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          }.height("100%")
          .justifyContent(FlexAlign.Center)


        Column(){
          Text("The most terrible enemy is no strong belief.")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          Text("最可怕的敌人，就是没有坚强的信念")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

        }.height("100%")
        .justifyContent(FlexAlign.Center)


        Column(){
          Text("The most terrible enemy is no strong belief.")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          Text("最可怕的敌人，就是没有坚强的信念")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

        }.height("100%")
        .justifyContent(FlexAlign.Center)

        Column(){
          Text("Knowledge is power.")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

          Text("知识就是力量")
            .fontSize(25)
            .width("90%")
            .height(100)
            .textAlign(TextAlign.Center)

        }.height("100%")
        .justifyContent(FlexAlign.Center)

      }
      .loop(true)
      .autoPlay(true)
      .height(500)
      .vertical(true)
      .indicatorStyle({
        color : '100000000'
      })
    }.width("100%")
    .height("1%")

  }
}