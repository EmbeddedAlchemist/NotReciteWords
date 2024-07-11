import fs from '@ohos.file.fs';
import util from '@ohos.util';
import http from '@ohos.net.http';
import { server } from '../Server';


export namespace WordBook {
  export interface WordBook {
    readonly id: string;
    readonly name: string;
    readonly desc: string;
    readonly cover: PixelMap | Resource | string;
    readonly totalWordCount: number;
    readonly type: string;
  }
  ;

  export class RemoteWordBook implements WordBook {
    readonly id: string;
    readonly name: string;
    readonly desc: string;
    readonly cover: PixelMap | Resource | string;
    readonly totalWordCount: number;
    readonly type: string;

    private constructor(wordBook: WordBook) {
      this.id = wordBook.id;
      this.name = wordBook.name;
      this.desc = wordBook.desc;
      this.cover = wordBook.cover;
      this.totalWordCount = wordBook.totalWordCount;
      this.type = wordBook.type;
    }

    static async queryAllBook(): Promise<RemoteWordBook[]> {
      let result: RemoteWordBook[] = [];

      let httpRequest = http.createHttp();
      let res = JSON.parse((await new Promise<http.HttpResponse>(
        function (resolve, reject) {
          httpRequest.request(
            `${server.ip}/book_list.json`,
            { method: http.RequestMethod.GET },
            (err, data: http.HttpResponse) => {
              if (err) reject(err);
              resolve(data);
            }
          )
        })).result as string)

      type listItem = {
        id: string;
        name: string;
        desc: string;
        word_count: number;
        type: string;
        tag: string[];
      }

      (res['list'] as Array<listItem>).forEach(item => {
        result.push(new RemoteWordBook({
          id: item.id,
          name: item.name,
          desc: item.desc,
          totalWordCount: item.word_count,
          cover: `${server.ip}/books/${item.id}/cover.png`,
          type: item.type
        }))
      })


      return result;
    }
  }

  type WordStudyStatus = {}

  type LocalBookListStruct = {
    book_list: string[]
  };

  type LocalBookDescStruct = {
    name: string;
    desc: string;
    total_word_count: number;
    type: string;
  }

  type LocalBookWordList = Record<string, WordStudyStatus>;

  export class LocalWordBook implements WordBook {
    readonly id: string;
    readonly name: string;
    readonly desc: string;
    readonly cover: PixelMap | Resource | string;
    readonly totalWordCount: number;
    readonly type: string;
    learnedWordCount: number;
    wordList: LocalBookWordList;

    private constructor(wordBook: WordBook, wordList: LocalBookWordList) {
      this.id = wordBook.id;
      this.name = wordBook.name;
      this.desc = wordBook.desc;
      this.cover = wordBook.cover;
      this.totalWordCount = wordBook.totalWordCount;
      this.wordList = wordList;
      this.type = wordBook.type;
    }

    static readonly coverPathFormat = '%s/local_book/%s/cover.png'
    static readonly bookDescPathFormat = '%s/local_book/%s/desc.json'
    static readonly wordListPathFormat = '%s/local_book/%s/word_list.json'
    static bookListPathFormat = '%s/local_book/book_list.json';

    async store() {
      const fileDir = getContext(this).filesDir;
      let file = await fs.open(
        `${fileDir}/local_book/${this.id}/word_list.json`,
        fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY
      );
      await fs.write(file.fd, JSON.stringify(this.wordList));
    };

    static async loadLocalBookList(): Promise<LocalBookListStruct> {
      let result: LocalBookListStruct = { book_list: [] };
      const fileDir = getContext(this).filesDir;
      let bookListPath = `${fileDir}/local_book/book_list.json`;
      console.log(bookListPath);
      if (await fs.access(bookListPath) != true) {
        await fs.mkdir(`${fileDir}/local_book`)
        let file = await fs.open(bookListPath, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY);
        await fs.write(file.fd, JSON.stringify(result));
        await fs.close(file);
      }
      result = JSON.parse(await fs.readText(bookListPath));
      return result
    }

    static async storeLocalBookList(list: LocalBookListStruct) {
      const fileDir = getContext(this).filesDir;
      let bookListPath = `${fileDir}/local_book/book_list.json`;
      let file = await fs.open(bookListPath, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY);
      await fs.write(file.fd, JSON.stringify(list));
      await fs.close(file);
      return;
    }

    static async load(id: string): Promise<LocalWordBook> {
      const fileDir = getContext(this).filesDir;
      let coverPath = `${fileDir}/local_book/${id}/cover.png`;
      let desc: LocalBookDescStruct = JSON.parse(await fs.readText(`${fileDir}/local_book/${id}/desc.json`));
      let wordList: LocalBookWordList = JSON.parse(await fs.readText(`${fileDir}/local_book/${id}/word_list.json`));
      return new LocalWordBook({
        id: id,
        name: desc.name,
        desc: desc.desc,
        cover: coverPath,
        totalWordCount: desc.total_word_count,
        type: desc.type
      },
        wordList);
    };

    static async queryAllBook(): Promise<LocalWordBook[]> {
      let bookList: LocalBookListStruct = await this.loadLocalBookList();
      let result: LocalWordBook[] = [];
      for (const id of bookList.book_list) {
        try {
          result.push(await this.load(id));
        }
        catch (e) {
        }
      }
      return result;
    }

    static async downloadFromRemote(remoteBook: RemoteWordBook) {
      const fileDir = getContext(this).filesDir;
      await fs.mkdir(`${fileDir}/local_book/${remoteBook.id}`);
      let coverResponse = await new Promise<http.HttpResponse>(function (resolve, reject) {
        let httpReq = http.createHttp();
        httpReq.request(
          remoteBook.cover as string,
          { method: http.RequestMethod.GET },
          (err, data) => {
            if (err) reject(err);
            resolve(data);
          }
        )
      })
      let file = await fs.open(
        `${fileDir}/local_book/${remoteBook.id}/cover.png`,
        fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY
      )
      await fs.write(file.fd, coverResponse.result as ArrayBuffer);
      fs.close(file);

      let wordListResponse = await new Promise<http.HttpResponse>(function (resolve, reject) {
        let httpReq = http.createHttp();
        httpReq.request(
          `${server.ip}/books/${remoteBook.id}/content.txt`,
          { method: http.RequestMethod.GET },
          (err, data) => {
            if (err) reject(err);
            resolve(data);
          }
        )
      });
      let wordArray = (wordListResponse.result as string).split('\r\n')
      let wordList: LocalBookWordList = {};
      for (const word of wordArray) {
        wordList[word] = {} as WordStudyStatus;
      }

      file = await fs.open(
        `${fileDir}/local_book/${remoteBook.id}/word_list.json`,
        fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY
      )
      await fs.write(file.fd, JSON.stringify(wordList));
      await fs.close(file);

      let bookDesc: LocalBookDescStruct = {
        name: remoteBook.name,
        desc: remoteBook.desc,
        total_word_count: remoteBook.totalWordCount,
        type: remoteBook.type
      }

      file = await fs.open(
        `${fileDir}/local_book/${remoteBook.id}/desc.json`,
        fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY
      )
      await fs.write(file.fd, JSON.stringify(bookDesc));
      await fs.close(file);

      let bookList = await this.loadLocalBookList();
      bookList.book_list.push(remoteBook.id);
      await this.storeLocalBookList(bookList);

    }
  }
}