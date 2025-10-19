@Entry
@Component
struct SwitchPicture {
  @State message: string = 'Hello World';
  @State isImageVisible: boolean = false;

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = this.isImageVisible ? 'Hello World' : '';
          this.isImageVisible = !this.isImageVisible;
        })

      Image($r('app.media.work'))
        .id('exampleImage')
        .width(200)
        .height(200)
        .visibility(this.isImageVisible ? Visibility.Visible : Visibility.None)
        .alignRules({
          top: { anchor: 'HelloWorld', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.isImageVisible = false;
          this.message = 'Hello World';
        })
    }
    .width('100%')
    .height('100%')
  }
}