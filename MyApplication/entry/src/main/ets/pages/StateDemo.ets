@Entry
@Component
struct Index {
  @State
  count: number = 0 //由@State装饰
  build() {
    Column() {
      Text(`刷新点击次数: ${this.count}`)
        .fontSize(30)
      MyButton( )                    //无参数实例化
      MyButton({ isClicked: false }) //带参数初始化
    }.width("100%").backgroundColor(0xff0000).padding(20)
    .onClick(() => { //点击响应
      this.count++   //更新内部状态数据，会重新build
    }
    )
  }
}

@Component
struct MyButton {
  @State isClicked: boolean = true //由@State装饰
  build() {
    Column() {
      Button() {
        Text(`当前状态: ${this.isClicked}`)
          .fontSize(20)
      }.margin(10).padding(5)
      .onClick(() => { //点击响应
        this.isClicked = !this.isClicked
      }
      )
    }
  }
}