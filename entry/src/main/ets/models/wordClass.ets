export class Word {
  isDelete:boolean = false
  isCollection:boolean = false
  correctIndex:number = 0
  correctTimes: number = 0
  word: {enValue: string, cnValue: string, type: string}
  exampleSentence: {enValue: string, cnValue: string}
  options: Array<{cnValue: string, type: string}>
  phrase: Array<{enValue: string, cnValue: string}>

  constructor(word: {enValue: string, cnValue: string, type: string},
              exampleSentence: {enValue: string, cnValue: string},
              options: Array<{cnValue: string, type: string}>,
              phrase: Array<{enValue: string, cnValue: string}>) {
    this.word = word
    this.exampleSentence = exampleSentence
    this.options = options
    this.phrase = phrase
  }

  public isPreview(): boolean {
    if (this.correctTimes >= 3) {
      return true
    }
    return false
  }

}


