import { WindowFrame } from '../Common/WindowFrame'
import { HeaderFrame } from '../Common/HeaderFrame'
import { HeaderIcon } from '../Common/HeaderIcon'
import { getTheme } from '../Common/Theme'


@Styles function styleSolidCard() {
  .backgroundColor(getTheme().colorScheme.surface)
  .borderRadius('10vp')
}

@Extend(Text) function styleHeader() {
  .fontColor(getTheme().colorScheme.onSurface)
  .fontSize('20fp')
  .fontWeight(FontWeight.Medium)
}


@Entry
@Component
struct Signage {
  @Builder
  headerLeftSlot() {
    HeaderIcon({ src: $r('app.media.down') });
  }

  @Builder
  headerRightSlot() {
    HeaderIcon({ src: $r('app.media.lightbulb') });
  }

  @Builder
  header() {
    HeaderFrame({
      title: '仪表盘',
      leftSlot: this.headerLeftSlot,
      rightSlot: this.headerRightSlot
    })
  }

  @Builder

  nowLearningCard(){

  }

  @Builder
  content() {
    Column() {
      Text('正在学习')
        .styleHeader();



      Column() {
        Scroll() {
          Row() {
            Text('PlaceHolder');
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')

        Row() {
          Checkbox();
          Text('生词本 0')
        }
        .width('100%')
        .alignSelf(ItemAlign.Start)

        Progress({ value: 535, total: 2213 })
          .color(getTheme().colorScheme.primary)
        Row(){
          Text('已学习 535')
            .fontColor(getTheme().colorScheme.onSurfaceLow)
            .fontSize('12fp')
          Text('总词数 2213')
            .fontColor(getTheme().colorScheme.onSurfaceLow)
            .fontSize('12fp')
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .styleSolidCard()
      .width('100%')
      .padding('20vp')


      Text('我的数据')
        .styleHeader()

      //概览
      Column(){
        Row(){
          Text('概览')
            .fontColor(getTheme().colorScheme.onSurface)
            .fontSize('14fp')
          Image($r('app.media.down'))
            .size({width:'14vp', height:'14vp'})
            .fillColor(getTheme().colorScheme.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .styleSolidCard()
      .padding('20vp')

      //日历
      Column(){
        Row(){
          Text('日历')
            .fontColor(getTheme().colorScheme.onSurface)
            .fontSize('14fp')
          Row(){
            Text('连续签到15天')
              .fontSize('12fp')
              .fontColor(getTheme().colorScheme.onSurface)
            Image($r('app.media.down'))
              .size({width:'14vp', height:'14vp'})
              .fillColor(getTheme().colorScheme.onSurface)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .styleSolidCard()
      .padding('20vp')

    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: '20vp', right: '20vp' })



  }

  build() {
    Column() {
      WindowFrame({
        content: this.content.bind(this),
        header: this.header.bind(this)
      })

    }
  }
}