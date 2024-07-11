import { ContentListenBean } from '../model/ContentListenBean'
import vm from "../viewmodel/MainViewModel"
import router from '@ohos.router'
@Entry
@Component
struct MyContentPage {
  build() {
    Column() {
      MyContentHeader()
      MyListen()
      MyContentKinds()
    }.backgroundColor("#F4F4F4")
    .height("100%")
  }
}

@Component
struct MyContentHeader {
  build() {
    Row() {
      Image($r("app.media.school_return"))
        .width(23)
        .height(23)
        .onClick(()=>{
          router.back()
        })

      Text("我的内容")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)

      Image($r("app.media.content_bulb"))
        .width(23)
        .height(23)
    }.width("100%")
    .padding({
      top: 20,
      left: 10,
      right: 10
    })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct MyListen {
  build() {
    List() {
      ForEach(vm.getMyContentListenList(), (item: ContentListenBean) => {
        ListItem() {
          MyListenItem({ item: item })
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .height(160)
    .borderRadius(20)
    .margin({
      top:30
    })
  }
}

@Component
struct MyListenItem{
  item:ContentListenBean
  build(){
    Column(){
      Row() {
        Image(this.item.img)
          .width(30)
          .height(30)
        Text(this.item.mainTitle)
          .fontSize(25)
          .fontWeight(FontWeight.Medium)
          .margin({
            left:5
          })
      }.width("100%")
      .margin({
        left:20,
        top:10
      })
      Row() {
        MyListenRectangle({ title: this.item.firstTitle, detil: this.item.firstDetil })
        MyListenRectangle({ title: this.item.secondTitle, detil: this.item.secondDetil })
      }
    }
    .width(280)
    .borderRadius(20)
    .backgroundColor("#FFECDA")
    .margin({
      left:15
    })
  }
}

@Component
struct MyListenRectangle {
  title: string
  detil: string

  build() {
    Column() {
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width("100%")
        .margin({
          left:25,
          top:10
        })
      Text(this.detil)
        .fontSize(15)
        .fontColor(Color.Grey)
        .fontWeight(FontWeight.Medium)
        .width("100%")
        .margin({
          left:25,
          top:5
        })
      Image($r("app.media.content_play"))
        .width(15)
        .height(15)
        .margin({
          top:20,
          left:60
        })
        .backgroundColor("#FFECDA")
    }.width(120)
    .height(100)
    .borderRadius(20)
    .backgroundColor("#F8F3EF")
    .margin({
      top:10,
      left:10,
      bottom:10
    })
  }
}

@Component
struct MyContentKinds{
  build(){
    Column(){

      Grid(){
        GridItem(){
          MyContentGridItem({img:$r("app.media.content_kind1"),kind:"在学词书",kindNumber:"2528词 >"})
        }
      }.rowsTemplate("1fr")
      .columnsTemplate("1fr")
      .backgroundColor(Color.White)
      .borderRadius(20)
      .height(50)
      .margin(10)

      Grid(){
        GridItem(){
          MyContentGridItem({img:$r("app.media.content_kind2"),kind:"近日已学",kindNumber:"今日28词 >"})
        }
        GridItem(){
          MyContentGridItem({img:$r("app.media.content_kind3"),kind:"全部已学",kindNumber:"5518词 >"})
        }
      }.rowsTemplate("1fr 1fr")
      .columnsTemplate("1fr")
      .backgroundColor(Color.White)
      .borderRadius(20)
      .height(100)
      .margin(10)

      Grid(){
        GridItem(){
          MyContentGridItem({img:$r("app.media.content_kind4"),kind:"单词本",kindNumber:"5本 >"})
        }
        GridItem(){
          MyContentGridItem({img:$r("app.media.content_kind5"),kind:"句库",kindNumber:"584句 >"})
        }
        GridItem(){
          MyContentGridItem({img:$r("app.media.content_kind6"),kind:"笔记",kindNumber:"465条 >"})
        }
      }.rowsTemplate("1fr 1fr 1fr")
      .columnsTemplate("1fr")
      .backgroundColor(Color.White)
      .borderRadius(20)
      .height(150)
      .margin(10)
    }
  }
}

@Component
struct MyContentGridItem{
  img:Resource
  kind:string
  kindNumber:string
  build(){
    Row(){
      Image(this.img)
        .width(35)
        .height(35)
      Text(this.kind)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .margin({
          left:10
        })
      Text(this.kindNumber)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Gray)
        .margin({
          left:125
        })
    }.width("90%")
    .justifyContent(FlexAlign.SpaceAround)
  }
}
