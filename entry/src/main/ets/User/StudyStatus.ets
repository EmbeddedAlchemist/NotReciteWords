import { WordBook } from './WordBook'
import fs from '@ohos.file.fs';
import http from '@ohos.net.http';

export namespace StudyStatus {
  let currentWordBook: WordBook.LocalWordBook = undefined;

  type CurrentWordBookStruct = {
    id: string;
  }

  async function loadCurrentWordBook() {
    const fileDir = getContext(this).filesDir;
    const confDir = `${fileDir}/current_word_book.json`
    if (false == await fs.access(confDir)){
      let firstRemoteBook = (await WordBook.RemoteWordBook.queryAllBook())[0];
      await WordBook.LocalWordBook.downloadFromRemote(firstRemoteBook);
      let curr:CurrentWordBookStruct = {id:firstRemoteBook.id};
      let file = await fs.open(confDir, fs.OpenMode.WRITE_ONLY|fs.OpenMode.CREATE);
      await fs.write(file.fd, JSON.stringify(curr));
      await fs.close((file));
    }
    let curr = JSON.parse(await fs.readText(confDir));
    currentWordBook = await WordBook.LocalWordBook.load(curr.id);
  }

  export async function getWordBook() {
    if (currentWordBook === undefined) {
      loadCurrentWordBook();
    }
    return currentWordBook;
  }

  export async function setWordBook(wordBook: WordBook.LocalWordBook) {
    const fileDir = getContext(this).filesDir;
    let curr:CurrentWordBookStruct = {id:wordBook.id};
    let file = await fs.open(`${fileDir}/current_word_book.json`, fs.OpenMode.WRITE_ONLY|fs.OpenMode.CREATE);
    await fs.write(file.fd, JSON.stringify(curr));
    await fs.close((file));
    currentWordBook = wordBook;
  }
}