@Component
export struct optionComponent {
  myIndex: number
  @Link points: Resource[]
  @Link isListVisible: boolean
  @Link isNextVisible: boolean
  @Prop cnValue: string
  @Prop type: string
  @State itemColor: string = "#EEFCFE"
  @Link correctTimes: number
  trueIndex: number

  build() {
    Column() {
      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Column({ space: 10 }) {
          Text(this.type).margin({ left: 10, top: 5 }).fontSize(16)
          Text(this.cnValue)
            .margin({ left: 10, top: 10 })
            .fontSize(20)
            .fontWeight(400)
        }.alignItems(HorizontalAlign.Start).width('100%')
        .backgroundColor(this.itemColor)
      }.height('100%').width('100%').backgroundColor(this.itemColor)
      .onClick(() => {
        // console.info("index" + `${this.myIndex}`)
        if (this.myIndex == this.trueIndex) {
          this.itemColor = "#24AB89"
          if (this.correctTimes <= 3) {
            this.correctTimes++
            this.points.shift()
            this.points.push($r("app.media.point_active"))
          }
          setInterval(() => {
            this.isListVisible = false
            this.isNextVisible = true
            return
          }, 1000)
        }
        else {
          this.itemColor = "#A50F3E"
          setInterval(() => {
            this.isListVisible = false
            this.isNextVisible = true
            return 
          }, 1000)
        }
      })
    }
    .width('100%')
    .height(70)

  }
}