import router from '@ohos.router';
import http from '@ohos.net.http';
import { HeaderFrame } from '../Common/HeaderFrame';
import { HeaderIcon } from '../Common/HeaderIcon';
import { getTheme } from '../Common/Theme';
import { WindowFrame } from '../Common/WindowFrame';
import hilog from '@ohos.hilog';
import resourceManager from '@ohos.resourceManager';
import { server } from '../Server';
import { WordBook } from '../User/WordBook';
import { StudyStatus } from '../User/StudyStatus';
import prompt from '@ohos.prompt';


@Styles function styleSolidCard() {
  .backgroundColor(getTheme().colorScheme.surface)
  .borderRadius('10vp')
}

@Extend(Text) function styleHeader() {
  .fontColor(getTheme().colorScheme.onSurface)
  .fontSize('20fp')
  .fontWeight(FontWeight.Medium)
}


type BookType = {
  name: string
  item: WordBook.WordBook[]
}


@Entry
@Component
struct BookSelect {
  @State
  currTypeSelectTabIndex: number = 0;
  @State
  books: BookType[] = []

  @Builder
  headerLeftSlot() {
    HeaderIcon({ src: $r('app.media.icon_arrow_back') })
      .onClick(event => {
        router.back()
      })
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
        .fontSize('16vp')
        .fontWeight(FontWeight.Medium)
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
    .padding({ left: '8vp', right: '8vp' })
  }

  @Builder
  bookItemBuilder(item: WordBook.WordBook) {
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

        Text(`${item.totalWordCount}词`)
          .fontSize('15fp')
          .fontColor(getTheme().colorScheme.onSurfaceLow)
      }
      .padding('6vp')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('96vp')
    .padding({ left: '20vp', right: '20vp' })

    .onClick( async e=> {
      try {
        if (item instanceof WordBook.LocalWordBook) {
          await StudyStatus.setWordBook(item)
        }
        else if (item instanceof WordBook.RemoteWordBook) {
          await WordBook.LocalWordBook.downloadFromRemote(item);
          await StudyStatus.setWordBook(await WordBook.LocalWordBook.load(item.id));
        }
        router.back();
      } catch (e){
        prompt.showToast({message:e});
      }

    })
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
              Column({ space: '30vp' }) {
                ForEach(elem.item, (elem: WordBook.WordBook, index) => {
                  this.bookItemBuilder(elem);
                })
              }
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

  async loadBookList() {

    try {
      this.books.push({ name: '我的', item: await WordBook.LocalWordBook.queryAllBook() });
    } catch (e) {
      console.log(e);
    }

    try {
      let remoteBooks = await WordBook.RemoteWordBook.queryAllBook();
      let tmp: Record<string, Array<WordBook.WordBook>> = {};
      for (const book of remoteBooks) {
        if (!tmp[book.type]) tmp[book.type] = [];
        tmp[book.type].push(book);
      }
      for (const key in tmp) {
        this.books.push({ name: key, item: tmp[key] })
      }
    } catch (e){
      console.error(e)
    }


  }

  aboutToAppear() {
    //this.requestBookList();
    this.loadBookList();
  }
}