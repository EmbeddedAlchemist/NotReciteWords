import { ContentListenBean } from '../model/ContentListenBean'

export class MainViewModel {
  getMyContentListenList(): Array<ContentListenBean> {
    let array: Array<ContentListenBean> = []
    array.push(new ContentListenBean($r("app.media.content_listen"), "随身听", "回顾", "15词", "预习", "30词"))
    array.push(new ContentListenBean($r("app.media.content_write"), "听写", "单元测", "60词", "随堂测", "45词"))
    return array
  }
}

export default new MainViewModel()