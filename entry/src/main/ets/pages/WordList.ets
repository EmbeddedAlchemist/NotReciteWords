import router from '@ohos.router'
import { YouDaoDict } from '../APIs/YouDaoDict'
import { HeaderFrame } from '../Common/HeaderFrame'
import { HeaderIcon } from '../Common/HeaderIcon'
import { getTheme } from '../Common/Theme'
import { WindowFrame } from '../Common/WindowFrame'
import { StudyStatus } from '../User/StudyStatus'
import { WordBook } from '../User/WordBook'

type WordItem = {
  word: string;
  explain: boolean;
  queryResult?: YouDaoDict.QueryResult;
}


@Entry
@Component
struct WordList {
  @BuilderParam title: string = '词汇表'
  @State wordList: WordItem[] = [];
  @State explainIndex:number = -1;

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
  buildWordItem(index: number, item: WordItem) {
    Column({ space: '12vp' }) {
      Row({ space: '6vp' }) {
        Text(item.word)
          .fontSize('18fp')
          .fontWeight(FontWeight.Bold)
          .fontColor(getTheme().colorScheme.onSurface)
        if (index == this.explainIndex) {
          Text(`/${item.queryResult.pronunciation.us}/`)
            .fontSize('18fp')
            .fontWeight(FontWeight.Normal)
            .fontColor(getTheme().colorScheme.onSurfaceLow)
        }
      }

      if (index == this.explainIndex) {
        Column() {
          ForEach(item.queryResult.meaning, m => {
            Text(`${m.position}${m.translation}}`);
          })
        }
        .alignItems(HorizontalAlign.Start)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({ left: '20vp', right: '20vp', top: '10vp', bottom: '10vp' })
    .onClick(async e => {
      let i = item;
      i.queryResult = await YouDaoDict.query(item.word);
      i.explain = true;
      this.wordList[index] = i;
      this.explainIndex = index;
    })
  }

  @Builder
  content() {
    List() {
      ForEach(this.wordList, (elem, index) => {
        ListItem() {
          this.buildWordItem(index, elem);
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
        this.wordList.push({ word: key, explain: false })
      }
    } catch (e) {
      console.log(e);
    }

    console.log("");
  }

  aboutToAppear() {
    this.loadWords();
  }
}