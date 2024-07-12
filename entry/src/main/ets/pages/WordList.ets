import router from '@ohos.router'
import { YouDaoDict } from '../APIs/YouDaoDict'
import { HeaderFrame } from '../Common/HeaderFrame'
import { HeaderIcon } from '../Common/HeaderIcon'
import { getTheme } from '../Common/Theme'
import { WindowFrame } from '../Common/WindowFrame'
import { StudyStatus } from '../User/StudyStatus'
import { WordBook } from '../User/WordBook'

// type WordItem = {
//   word: string;
//   explain: boolean;
//   queryResult?: YouDaoDict.QueryResult;
// }

@Component
struct WordItem{
  @State explain:boolean = false;
  word:string = '';
  @State queryResult?: YouDaoDict.QueryResult = undefined;

  build(){
    Column({ space: '12vp' }) {
      Row({ space: '6vp' }) {
        Text(this.word)
          .fontSize('18fp')
          .fontWeight(FontWeight.Bold)
          .fontColor(getTheme().colorScheme.onSurface)
        if (this.explain) {
          Text(`/${this.queryResult.pronunciation.us}/`)
            .fontSize('18fp')
            .fontWeight(FontWeight.Normal)
            .fontColor(getTheme().colorScheme.onSurfaceLow)
        }
      }

      if (this.explain) {
        Column({space:'4vp'}) {
          ForEach(this.queryResult.meaning, m => {
            Text(`${m.position} ${m.translation}}`)
              .fontSize('14fp')
              .fontColor(getTheme().colorScheme.onSurface)
          })
        }
        .alignItems(HorizontalAlign.Start)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({ left: '20vp', right: '20vp', top: '10vp', bottom: '10vp' })
    .backgroundColor(this.explain?getTheme().colorScheme.surface : getTheme().colorScheme.surfaceContainer)
    .onClick(async e => {
      this.queryResult = await YouDaoDict.query(this.word);
      this.explain = true;
    })
  }
}

@Entry
@Component
struct WordList {
  @BuilderParam title: string = '词汇表'
  wordList: string[] = [];


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
      title: this.title,
      leftSlot: this.headerLeftSlot,
      rightSlot: this.headerRightSlot
    })
  }


  @Builder
  content() {
    List() {
      ForEach(this.wordList, (elem:string, index) => {
        ListItem() {
          WordItem({word:elem})
        }
        .width('100%')
      })
    }
    .width('100%')
  }

  build() {
    Column() {
      WindowFrame({
        content: this.content.bind(this),
        header: this.header.bind(this)
      })

    }
  }

  async loadWords() {
    let wordBook: WordBook.LocalWordBook = undefined;
    try {
      wordBook = await StudyStatus.getWordBook();
      for (const key in wordBook.wordList) {
        this.wordList.push(key)
      }
    } catch (e) {
      console.log(e);
    }
  }

  aboutToAppear() {
    this.loadWords();
  }
}