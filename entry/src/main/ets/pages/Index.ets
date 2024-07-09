import router from '@ohos.router'
import { Word } from '../models/wordClass'

@Entry
@Component
struct Index {
  @State currentWords: Array<Word> = []
  @State index: number = 0
  @State star: Resource = $r("app.media.star_inactive")
  @State starState: boolean = false
  @State isPromptVisible: Boolean = true
  @State isGridVisible: Boolean = true
  @State currentWord: Word = new Word(
    // ["Apple", "苹果", "名词"]
    { enValue: "Apple", cnValue: "ping", type: "n" },
    { enValue: "An apple a day keeps the doctor away.", cnValue: "一天一个苹果，医生远离我。" },
    [{ cnValue: "苹果", type: "名词" }, { cnValue: "苹果公司", type: "专有名词" }, {
      cnValue: "所有物",
      type: "名词"
    }, { cnValue: "伐木作业", type: "名词" }],
    [{ enValue: "apple pie", cnValue: "苹果派" }, { enValue: "apple juice", cnValue: "苹果汁" }]
  )

  aboutToAppear() {
    InitWords(this.currentWords)
    console.info(`${this.currentWords}`)
  }

  build() {
    Column() {
      Row() {
        //返回按钮
        Button('<')
          .backgroundColor('#FFFFF')
          .fontColor(Color.Blue)
          .fontSize(30)

        Text(`${this.index}` + '/10')
          .margin({ left: 30 })
          .fontSize(25)
        //收藏
        Image(this.star)
          .height(40)
          .width(40)
          .margin({ left: 30 })
          .onClick(() => {
            if (!this.starState) {
              this.star = $r("app.media.star_active")
            }
            else {
              this.star = $r("app.media.star_inactive")
            }
            this.starState = !this.starState
          })
        //删除
        Image($r("app.media.delete"))
          .height(30)
          .width(30)
          .margin({ left: 30 })
        //更多
        Image($r("app.media.more"))
          .height(30)
          .width(30)
          .margin({ left: 30 })

      }.margin({ top: 30 })

      Column() {
        Row() {
          Text(this.currentWord.word['enValue'])
            .height(80)
            .fontSize(50)
            .fontWeight(600)
            .margin({ left: 0, top: 60 })
          Column() {
            Image($r("app.media.point_inactive"))
              .width(25)
              .height(10)
            Image($r("app.media.point_inactive"))
              .width(25)
              .height(10)
            Image($r("app.media.point_inactive"))
              .width(25)
              .height(10)
          }.margin({ top: 80 }).height(40)
        }.justifyContent(FlexAlign.Start).width('80%')

        Text('先回想词义再选择，想不起来[看答案]')
          .margin({ top: 30})
      }.width('90%')

      List({space:30}) {
        ForEach(this.currentWord.options, item => {
          ListItem() {
            Column({ space: 10 }) {
              Text(item['type']).margin({left:10,top:5}).fontSize(16)
              Text(item['cnValue']).margin({left:10,top:10}).fontSize(20).fontWeight(400)
            }.width('100%').height(70)
            .alignItems(HorizontalAlign.Start)
            .backgroundColor("#EEFCFE")
            .borderRadius(5)
            // .backgroundColor(Color.Red)
          }
        }, item => item['cnValue'] + '')
      }.width('80%').margin({top:60})


      Text('看答案').textAlign(TextAlign.Center).margin({top:40}).fontWeight(600).fontSize(20)
      Blank()
    }.width('100%').height('100%')
    .backgroundImage($r("app.media.backgroundImage"),ImageRepeat.NoRepeat)
    .backgroundImageSize(ImageSize.Cover)
  }
}

function InitWords(currentWords: Array<Word>) {
  let params: object = router.getParams()
}
