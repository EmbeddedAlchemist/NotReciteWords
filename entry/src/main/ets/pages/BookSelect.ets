import { HeaderFrame } from '../Common/HeaderFrame';
import { HeaderIcon } from '../Common/HeaderIcon';
import { getTheme } from '../Common/Theme';
import { WindowFrame } from '../Common/WindowFrame';


@Styles function styleSolidCard() {
  .backgroundColor(getTheme().colorScheme.surface)
  .borderRadius('10vp')
}

@Extend(Text) function styleHeader() {
  .fontColor(getTheme().colorScheme.onSurface)
  .fontSize('20fp')
  .fontWeight(FontWeight.Medium)
}

type BookItem = {
  cover: PixelMap | Resource;
  name: string;
  desc: string;
  wordCount: number;
}

type BookType = {
  name: string
  item: BookItem[]
}


@Entry
@Component
struct BookSelect {
  @State
  currTypeSelectTabIndex: number = 0;
  @State
  books: BookType[] = [
    { name: '我的', item: [
      { cover: $r('app.media.book_cover'),
        name: '母猪的产后护理',
        desc: '这是一条测试数据',
        wordCount: 114514 }
    ] },
    { name: '大学', item: [
      { cover: $r('app.media.book_cover'),
        name: '母猪的产后护理(大学)',
        desc: '大学生就该学这个',
        wordCount: 1919810 }
    ] },
  ]

  @Builder
  headerLeftSlot() {
    HeaderIcon({ src: $r('app.media.icon_arrow_back') })
  }

  @Builder
  headerRightSlot() {
  }

  @Builder
  header() {
    HeaderFrame({
      title: '词库',
      leftSlot: this.headerLeftSlot,
      rightSlot: this.headerRightSlot
    })
  }

  @Builder
  typeSelectTabBuilder(index: number, text: string) {
    Column({ space: '2vp' }) {
      Text(text)
        .fontSize('18vp')
        .fontColor(
            index == this.currTypeSelectTabIndex
            ? getTheme().colorScheme.onSurface
            : getTheme().colorScheme.onSurfaceLow
        )
      Line({ width: '20vp', height: '3vp' })
        .startPoint(['0vp', '1.5vp'])
        .endPoint(['20vp', '1.5vp'])
        .stroke(
            index == this.currTypeSelectTabIndex
            ? getTheme().colorScheme.primary
            : Color.Transparent
        )
        .strokeWidth('3dp')
    }
    .padding({ left: '4vp', right: '4vp' })
  }

  @Builder
  bookItemBuilder(item: BookItem) {
    Row({ space: '12vp' }) {
      Image(item.cover)
        .height('100%')
        .borderRadius('8vp')
      Column() {
        Column({ space: '4vp' }) {
          Text(item.name)
            .fontSize('18fp')
            .fontWeight(FontWeight.Medium)
            .fontColor(getTheme().colorScheme.onSurface)
          Text(item.desc)
            .fontSize('14fp')
            .fontColor(getTheme().colorScheme.onSurfaceLow)
        }
        .alignItems(HorizontalAlign.Start)

        Text(`${item.wordCount}词`)
          .fontSize('15fp')
          .fontColor(getTheme().colorScheme.onSurfaceLow)
      }
      .padding('6vp')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('156vp')
    .padding('20vp')
  }

  @Builder
  content() {
    Column() {
      Search()
        .margin({ left: '20vp', right: '20vp' })
      Tabs({ barPosition: BarPosition.Start }) {

        ForEach(this.books, (elem: BookType, index) => {
          TabContent() {
            Scroll() {
              ForEach(elem.item, (elem: BookItem, index) => {
                this.bookItemBuilder(elem);
              })
            }
            .size({ width: '100%', height: '100%' })
            .align(Alignment.Top)
          }
          .tabBar(this.typeSelectTabBuilder(index, elem.name))
        })
      }
      .barMode(BarMode.Scrollable)
      .onChange(index => this.currTypeSelectTabIndex = index);
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