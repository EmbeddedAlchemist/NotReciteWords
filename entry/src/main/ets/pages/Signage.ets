import { WindowFrame } from 'ets/Common/WindowFrame'
import { HeaderFrame } from 'ets/Common/HeaderFrame'
import { HeaderIcon } from 'ets/Common/HeaderIcon'
import { getTheme } from 'ets/Common/Theme'
import distributedKVStore from '@ohos.data.distributedKVStore'
import featureAbility from '@ohos.ability.featureAbility'
import router from '@ohos.router'
import { StudyStatus } from '../User/StudyStatus'


@Styles function styleSolidCard() {
  .backgroundColor(getTheme().colorScheme.surface)
  .borderRadius('10vp')
}

@Extend(Text) function styleHeader() {
  .fontColor(getTheme().colorScheme.onSurface)
  .fontSize('20fp')
  .fontWeight(FontWeight.Medium)
}


@Component
struct StudyProgressCard {
  @State bookCoverImg: Resource | PixelMap  = $r('app.media.book_cover');
  @State totalWordCount: number = 2213;
  @State learnedWordCount: number = 535;
  @State markedWordCount: number = 0;

  @Builder bookOptionMenu() {
    Menu() {
      MenuItem({ content: '查看词书单词表' })
      MenuItem({ content: '下载离线单词包' })
      MenuItem({ content: '重学词书' })
      MenuItem({ content: '更新词书' })
    }

  }

  build() {
    Column({ space: '20vp' }) {
      Flex() {
        Scroll() {
          Row({ space: '20vp' }) {
            Image(this.bookCoverImg)
              .height('100%')
              .borderRadius('8vp')
            .onClick(e=>router.pushUrl({url:'pages/WordList'}))
            Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
              Text('配套真题词组')
                .fontSize('12fp')
                .fontColor(getTheme().colorScheme.onSurface)
                .margin({ bottom: '8vp' })
              Column() {
                Image($r('app.media.icon_add'))
                  .size({ width: '20vp', height: '20vp' })
                  .fillColor(getTheme().colorScheme.onSurfaceLowest)
              }
              .width('100%')
              .height('100%')
              .border({ color: getTheme().colorScheme.onSurfaceLowest, radius: '4vp', width: '1vp' })
              .align(Alignment.Center)
              .justifyContent(FlexAlign.Center)
            }
            .height('100%')
            .width('80vp')

          }
          .alignSelf(ItemAlign.Start)
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .height('128vp')
        .align(Alignment.Start)

        Image($r('app.media.icon_more_vert'))
          .size({ width: '24vp', height: '24vp' })
          .fillColor(getTheme().colorScheme.onSurfaceLow)
          .bindMenu(this.bookOptionMenu)
      }
      .width('100%')

      Row({ space: '4vp' }) {
        Checkbox()
          .selectedColor(getTheme().colorScheme.primary)
        Text(`生词本 ${this.markedWordCount}`)
          .fontColor(getTheme().colorScheme.onSurface)
          .fontSize('14vp')
      }
      .width('100%')
      .alignSelf(ItemAlign.Start)

      Column({ space: '2vp' }) {
        Progress({ value: this.learnedWordCount, total: this.totalWordCount })
          .color(getTheme().colorScheme.primary)
          .style({
            strokeWidth: '6vp'
          })
        Row() {
          Text(`已学习 ${this.learnedWordCount}`)
            .fontColor(getTheme().colorScheme.onSurfaceLow)
            .fontSize('12fp')
          Text(`总词数 ${this.totalWordCount}`)
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

  async loadData(){
    let currBook = await StudyStatus.getWordBook();
    //this.bookCoverImg = currBook.cover;
    this.totalWordCount = currBook.totalWordCount;
    this.learnedWordCount = currBook.learnedWordCount;
  }

  aboutToAppear(){
    this.loadData();
  }
}

@Component
struct DataPreviewCard {
  @State todayLearnedCount: number = 0
  @State totalLearnedCount: number = 0
  @State todayLearnedTime: number = 0
  @State totalLearnedTime: number = 0

  @Builder
  reviewItem(
    icon: Resource,
    color: string | Resource | Color,
    title: string,
    value: string,
    unit: string) {
    Row({ space: '8vp' }) {
      Image(icon)
        .fillColor(color)
        .size({ width: '16vp', height: '16vp' })
      Column({ space: '8vp' }) {
        Text(title)
          .fontSize('12fp')
          .fontColor(getTheme().colorScheme.onSurface)
          .fontWeight(FontWeight.Medium)
        Row({ space: '6vp' }) {
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

  build() {
    //概览
    Column({ space: '10vp' }) {
      Row() {
        Text('概览')
          .fontColor(getTheme().colorScheme.onSurface)
          .fontSize('14fp')
          .fontWeight(FontWeight.Medium)
        Image($r('app.media.icon_keyboard_arrow_right'))
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
          this.reviewItem($r("app.media.icon_bar_chart"), '#e2be30', '今日学习&复习', this.todayLearnedCount.toString(), '词')
        }

        GridCol() {
          this.reviewItem($r("app.media.icon_monitoring"), '#d1656c', '累计学习', this.totalLearnedCount.toString(), '词')
        }

        GridCol() {
          this.reviewItem($r("app.media.icon_avg_pace"), '#e2be30', '今日总时长', this.todayLearnedTime.toString(), '分钟')
        }

        GridCol() {
          this.reviewItem($r("app.media.icon_schedule"), '#d1656c', '累计时长', this.totalLearnedTime.toString(), '分钟')
        }
      }

    }
    .width('100%')
    .styleSolidCard()
    .padding('20vp')
  }
}


type CalendarItem = {
  weekDay: string;
  monthDay: number;
  isChecked: boolean;
  isToday: boolean;
}

@Component
struct CalendarCard {
  @State calendarItem: CalendarItem[] = [
    { weekDay: 'MON', monthDay: 8, isChecked: true, isToday: false },
    { weekDay: 'TUE', monthDay: 9, isChecked: true, isToday: true },
    { weekDay: 'WED', monthDay: 10, isChecked: false, isToday: false },
    { weekDay: 'THU', monthDay: 11, isChecked: false, isToday: false },
    { weekDay: 'FRI', monthDay: 12, isChecked: false, isToday: false },
    { weekDay: 'SAT', monthDay: 13, isChecked: false, isToday: false },
    { weekDay: 'SUN', monthDay: 14, isChecked: false, isToday: false },

  ]
  @State continueCheckCount: number = 16;

  @Builder
  calendarItemBuilder(item: CalendarItem) {
    Column({ space: '10vp' }) {
      Text(item.weekDay)
        .fontSize('10fp')
        .fontColor(item.isChecked ? getTheme().colorScheme.primary : getTheme().colorScheme.onSurfaceLow)
      Text(item.isToday ? '今' : item.monthDay.toString())
        .fontSize('11vp')
        .fontWeight(FontWeight.Bold)
        .size({ width: '20vp', height: '20vp' })
        .borderRadius('10vp')
        .backgroundColor(item.isChecked || item.isToday ? getTheme().colorScheme.primary : Color.Transparent)
        .fontColor(item.isChecked || item.isToday ? getTheme().colorScheme.onPrimary : getTheme()
                                                                                         .colorScheme
                                                                                         .onSurfaceContainer)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column({ space: '20vp' }) {
      Row() {
        Text('日历')
          .fontColor(getTheme().colorScheme.onSurface)
          .fontSize('14fp')
        Row() {
          Text(`连续签到${this.continueCheckCount}天`)
            .fontSize('12fp')
            .fontColor(getTheme().colorScheme.onSurface)
          Image($r('app.media.icon_keyboard_arrow_right'))
            .size({ width: '14vp', height: '14vp' })
            .fillColor(getTheme().colorScheme.onSurface)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        ForEach(this.calendarItem, (elem: CalendarItem) => {
          this.calendarItemBuilder(elem);
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .styleSolidCard()
    .padding('20vp')
  }
}

@Entry
@Component
struct Signage {
  @Builder
  headerLeftSlot() {
    HeaderIcon({ src: $r('app.media.icon_keyboard_arrow_down') })
      .onClick(event => {
        router.back()
      })
  }

  @Builder
  headerRightSlot() {
    HeaderIcon({ src: $r('app.media.icon_ios_share') });
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
  content() {
    Scroll() {
      Column({ space: '16vp' }) {
        Row() {
          Text('正在学习')
            .styleHeader()
            .margin({ top: '10vp' })
          Button('换本词书')
            .fontColor(getTheme().colorScheme.onPrimaryContainer)
            .backgroundColor(getTheme().colorScheme.primaryContainer)
            .fontSize('12fp')
            .height('0vp')
            .padding({ left: '12vp', right: '12vp', top: '6vp', bottom: '6vp' })
            .onClick(event => {
              router.pushUrl({ url: 'pages/BookSelect' })
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.SpaceBetween)

        StudyProgressCard();

        Text('我的数据')
          .styleHeader()
          .margin({ top: '10vp' })


        DataPreviewCard()
        CalendarCard()

        Blank().height('50vp')

      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ left: '20vp', right: '20vp' })
    }

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