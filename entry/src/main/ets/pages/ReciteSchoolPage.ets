import backgroundTaskManager from '@ohos.backgroundTaskManager'
import router from '@ohos.router'
@Entry
@Component
struct ReciteSchoolPage {
  build() {
    Scroll() {
      Column() {
        MySchoolHeader()
        MySchoolSwiper()
        MySchoolTitle({ title: "精品课程" })
        MySchoolCourse()
        MySchoolTitle({ title: "快速上手" })
        MySchoolStart()
        MySchoolTitle({ title: "学习攻略" })
        MySchoolMethod()
      }
    }.backgroundColor("#F4F4F4")
  }
}

@Component
struct MySchoolHeader {
  build() {
    Row() {
      Image($r("app.media.school_return"))
        .width(25)
        .height(25)
        .margin({
          left: 6
        }).onClick(()=>{
        router.back()
      })
      Text("不背学堂")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .margin({
          left: 105
        })
    }.width("100%")
    .padding({
      top: 25
    })
    //.backgroundColor(Color.Blue)
  }
}

@Component
struct MySchoolTitle {
  title: string

  build() {
    Text(this.title)
      .fontSize(23)
      .fontWeight(FontWeight.Medium)
      .width("100%")
      .margin({
        top: 20,
        left: 10,
        bottom: 10
      })
  }
}

@Styles function MySwiperImageStyles() {
  .width("100%")
  .height(150)
  .borderRadius(10)
  .padding({
    left: 10,
    right: 10,
    top: 15
  })
}

@Component
struct MySchoolSwiper {
  build() {
    Swiper() {
      Image($r("app.media.school_banner1"))
        .MySwiperImageStyles()
      Image($r("app.media.school_banner2"))
        .MySwiperImageStyles()
      Image($r("app.media.school_banner3"))
        .MySwiperImageStyles()
      Image($r("app.media.school_banner4"))
        .MySwiperImageStyles()
    }.autoPlay(true)
    .loop(true)
  }
}

@Component
struct MySchoolCourse {
  build() {
    Column() {
      Grid() {
        GridItem() {
          MyGridCourseItem({ title: "四级听力 阶梯训练", detail: "轻松练真题", img: $r("app.media.school_course1") })
        }

        GridItem() {
          MyGridCourseItem({ title: "英语解词", detail: "词根词缀，图记单词", img: $r("app.media.school_course2") })
        }

        GridItem() {
          MyGridCourseItem({ title: "考研写作炼句", detail: "快速炼制高分金句", img: $r("app.media.school_course3") })
        }

        GridItem() {
          MyGridCourseItem({ title: "口语达人", detail: "地道口语特训课", img: $r("app.media.school_course4") })
        }
      }.rowsTemplate("1fr 1fr")
      .columnsTemplate("1fr 1fr")
      .height(180)
    }.width("100%")
  }
}

@Component
struct MyGridCourseItem {
  title: string
  detail: string
  img: Resource

  build() {
    Row() {
      Image(this.img)
        .width(30)
        .height(30)
        .backgroundColor(Color.Orange)
      Column() {
        Text(this.title)
          .fontWeight(FontWeight.Bold)
          .margin({
            left: 5
          })
        Text(this.detail)
          .fontSize(15)
          .fontColor(Color.Gray)
          .margin({
            left: 5
          })
      }
    }.height(80)
    .width(170)
    .backgroundColor(Color.White)
    .borderRadius(20)
  }
}

@Styles function MyStartImageStyles() {
  .width(160)
  .height(100)
  .borderRadius(10)
  .padding({
    left: 10
  })
}

@Component
struct MySchoolStart {
  build() {
    Scroll() {
      Row() {
        Image($r("app.media.school_start1"))
          .MyStartImageStyles()
        Image($r("app.media.school_start2"))
          .MyStartImageStyles()
        Image($r("app.media.school_start3"))
          .MyStartImageStyles()
        Image($r("app.media.school_start4"))
          .MyStartImageStyles()
      }
    }.scrollable(ScrollDirection.Horizontal)

  }
}

@Component
struct MySchoolMethod {
  build() {
    Column() {
      Row() {
        Text("玩转不背")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
        Text("共9篇 >")
          .fontSize(18)
      }.width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(10)

      Grid() {
        GridItem() {
          MyGridMethodItem({
            title: "英语备考：4步跨越单词关",
            detail: "词书、考义、词组",
            browse: "5024.2k浏览",
            img: $r("app.media.school_method1")
          })
        }

        GridItem() {
          MyGridMethodItem({
            title: "不背的例句有什么特别之处？",
            detail: "融入语境自然会",
            browse: "5662.5k浏览",
            img: $r("app.media.school_method2")
          })
        }

        GridItem() {
          MyGridMethodItem({
            title: "「我的内容」使用指南",
            detail: "当日回顾",
            browse: "4232.9k浏览",
            img: $r("app.media.school_method3")
          })
        }

        GridItem() {
          MyGridMethodItem({
            title: "随身听:单词还能闭眼背",
            detail: "碎片时间,随时听记",
            browse: "1535.5k浏览",
            img: $r("app.media.school_method4")
          })
        }

        GridItem() {
          MyGridMethodItem({
            title: "真题词组,高分必备",
            detail: "关联学习，双倍收获",
            browse: "3284.4k浏览",
            img: $r("app.media.school_method5")
          })
        }
      }
    }
    .borderRadius(20)
    .backgroundColor(Color.White)
    .margin(10)
  }
}

@Component
struct MyGridMethodItem {
  title: string
  detail: string
  browse: string
  img: Resource

  build() {
    Row() {
      Image(this.img)
        .width(70)
        .height(70)
        .borderRadius(5)
      Column() {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .margin({
            left: 15
          })
        Row() {
          Text(this.detail)
            .fontSize(15)
            .fontColor(Color.Gray)
          Text(this.browse)
            .fontSize(15)
            .fontColor(Color.Gray)

        }.width("70%")
        .margin({
          top:10,
          left:10
        })
        .justifyContent(FlexAlign.SpaceBetween)
      }
    }.margin(10)
  }
}