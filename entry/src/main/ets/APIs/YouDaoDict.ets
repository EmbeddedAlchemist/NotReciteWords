import http from '@ohos.net.http';

import fs from '@ohos.file.fs';
import ReadOptions from "@ohos.file.fs"
import common from '@ohos.app.ability.common';
import buffer from '@ohos.buffer';


export namespace YouDaoDict {

  const BUFFER_FILE_PATH = '/you_dao_dict_cache.json';

  export type QueryResult = {
    source: string;
    pronunciation: {
      en?: string;
      us?: string;
    };
    meaning: Array<{
      position?: string;
      translation: string;
    }>;
    sentence: Array<{
      sentence: string;
      translation: string;
    }>;
  };

  let queryCache: Record<string, QueryResult> = undefined;

  async function loadLocalCache() {
    let context = getContext(this) as common.UIAbilityContext;
    let filePath = `${context.cacheDir}${BUFFER_FILE_PATH}`
    let file: fs.File;
    if (!await fs.access(filePath)) {
      file = await fs.open(filePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      await fs.write(file.fd, '{}');
      await fs.fdatasync(file.fd);
      await fs.close(file);
    }
    queryCache = JSON.parse(await fs.readText(filePath, { encoding: 'UTF-8' }));
  }

  async function cacheQuery(word: string): Promise<QueryResult> {
    if (queryCache === undefined) await loadLocalCache();
    let result = queryCache[word];
    if (result !== undefined) return result
    return null;
  }

  async function cacheAdd(word: string, result: QueryResult): Promise<void> {
    queryCache[word] = result;
    let serialized = JSON.stringify(queryCache);
    let context = getContext(this) as common.UIAbilityContext;
    let filePath = `${context.cacheDir}${BUFFER_FILE_PATH}`
    let file = await fs.open(filePath, fs.OpenMode.WRITE_ONLY | fs.OpenMode.CREATE);
    await fs.write(file.fd, serialized);
    await fs.fsync(file.fd);
    await fs.close(file);
  }

  export async function query(word: string): Promise<QueryResult> {
    let result: QueryResult | null = await cacheQuery(word);
    if (result) return result;
    let httpReq = http.createHttp();
    let httpResponse = await new Promise<http.HttpResponse>((resolve, reject) => {
      httpReq.request(
        'https://dict.youdao.com/jsonapi_s?doctype=json&jsonversion=4',
        {
          method: http.RequestMethod.POST,
          header:{
            'Content-Type':'application/x-www-form-urlencoded'
          },
          extraData: `q=${word}`
        },
        (err, data) => {
          if (err !== undefined) reject(err);
          resolve(data)
        }
      )
    })
    let res = JSON.parse(httpResponse.result.toString());
    result = {
      source: word,
      pronunciation: {
        en: res['ec']['word']['ukphone'] as string,
        us: res['ec']['word']['usphone'] as string
      },
      meaning: [],
      sentence: []
    };
    (res['ec']['word']['trs'] as Array<{
      pos?: string;
      tran: string
    }>).forEach(elem => {
      result.meaning.push({ position: elem.pos, translation: elem.tran });
    });
    (res['blng_sents_part']['sentence-pair'] as Array<{
      sentence?: string;
      'sentence-translation': string
    }>).forEach(elem => {
      result.sentence.push({ sentence: elem.sentence, translation: elem['sentence-translation'] });
    })

    cacheAdd(word, result);
    return res
  }
}