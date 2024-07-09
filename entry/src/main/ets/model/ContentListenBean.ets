export class ContentListenBean {
  img: Resource
  mainTitle: string
  firstTitle: string
  firstDetil: string
  secondTitle: string
  secondDetil: string

  constructor(img: Resource, mainTitle: string, firstTitle: string, firstDetil: string, secondTitle: string, secondDetil: string) {
    this.img=img
    this.mainTitle=mainTitle
    this.firstTitle=firstTitle
    this.firstDetil=firstDetil
    this.secondTitle=secondTitle
    this.secondDetil=secondDetil
  }
}