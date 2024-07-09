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
  nowLearningCard() {
    Column({ space: '20vp' }) {
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

      Column() {
        Progress({ value: 535, total: 2213 })
          .color(getTheme().colorScheme.primary)
          .style({
            strokeWidth: '6vp'
          })
        Row() {
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
    }
    .styleSolidCard()
    .width('100%')
    .padding('20vp')
  }

  @Builder
  reviewItem(
    icon: Resource,
    color: string | Resource | Color,
    title: string,
    value: string,
    unit: string) {
    Row({space:'8vp'}) {
      Image(icon)
        .fillColor(color)
        .size({ width: '16vp', height: '16vp' })
      Column({space:'8vp'}) {
        Text(title)
        .fontSize('12fp')
        .fontColor(getTheme().colorScheme.onSurface)
        .fontWeight(FontWeight.Medium)
        Row({space:'6vp'}) {
          Text(value)
            .fontSize('24vp')
            .fontColor(getTheme().colorScheme.onSurface)
            .fontWeight(FontWeight.Bold)
          Text(unit)
            .fontSize('12vp')
            .fontColor(getTheme().colorScheme.onSurfaceLow)
        }
        .alignSelf(ItemAlign.Baseline)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }

  @Builder
  reviewCard() {
    //概览
    Column({space:'10vp'}) {
      Row() {
        Text('概览')
          .fontColor(getTheme().colorScheme.onSurface)
          .fontSize('14fp')
          .fontWeight(FontWeight.Medium)
        Image($r('app.media.down'))
          .size({ width: '14vp', height: '14vp' })
          .fillColor(getTheme().colorScheme.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      GridRow({
        columns: 2,
        gutter: '20vp'
      }) {
        GridCol() {
          this.reviewItem(
            $r('app.media.bar_chart_24dp_5F6368_FILL0_wght400_GRAD0_opsz24'),
            '#e2be30',
            '今日学习&复习',
            '2',
            '词'
          )
        }

        GridCol() {
          this.reviewItem(
            $r('app.media.finance_24dp_5F6368_FILL0_wght400_GRAD0_opsz24'),
            '#d1656c',
            '累计学习',
            '5370',
            '词'
          )
        }


        GridCol() {
          this.reviewItem(
            $r('app.media.avg_pace_24dp_5F6368_FILL0_wght400_GRAD0_opsz24'),
            '#e2be30',
            '今日总时长',
            '7',
            '分钟'
          )
        }

        GridCol() {
          this.reviewItem(
            $r('app.media.schedule_24dp_5F6368_FILL0_wght400_GRAD0_opsz24'),
            '#d1656c',
            '累计时长',
            '4069',
            '分钟'
          )
        }
      }

    }
    .width('100%')
    .styleSolidCard()
    .padding('20vp')
  }

  @Builder
  content() {
    Column({ space: '16vp' }) {
      Row() {
        Text('正在学习')
          .styleHeader()
          .margin({ top: '10vp' })
        Button('换本词书')
          .fontColor(getTheme().colorScheme.onPrimaryContainer)
          .backgroundColor(getTheme().colorScheme.primaryContainer)
          .fontSize('12fp')
          .fontWeight(FontWeight.Bold)
          .height('0vp')
          .padding({ left: '12vp', right: '12vp', top: '6vp', bottom: '6vp' })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      this.nowLearningCard();

      Text('我的数据')
        .styleHeader()
        .margin({ top: '10vp' })


      this.reviewCard();

      //日历
      Column() {
        Row() {
          Text('日历')
            .fontColor(getTheme().colorScheme.onSurface)
            .fontSize('14fp')
          Row() {
            Text('连续签到15天')
              .fontSize('12fp')
              .fontColor(getTheme().colorScheme.onSurface)
            Image($r('app.media.down'))
              .size({ width: '14vp', height: '14vp' })
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