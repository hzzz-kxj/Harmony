@Entry
@Component
struct ParentComponent {
  @State goldCount: number = 10 // 由@State装饰的变量
  build() {
    Column() {
      Row() {
        Text(`初始化金币数量：${this.goldCount} `)
          .margin(10).fontSize(15)

        Button() {
          Text(' -1 ')
        }.margin(5).size({ height: 30, width: 30 })
        .backgroundColor(0xccccff)
        .onClick(() => { // 点击响应
          this.goldCount -= 1
        })

        Button() {
          Text(' +1 ')
        }.margin(5).size({ height: 30, width: 30 })
        .backgroundColor(0xccccff)
        .onClick(() => { // 点击响应
          this.goldCount += 1
        })
      }.margin(10)

      //下面创建三个子组件，必须初始化@Prop变量count
      //普通变量可以不通过参数初始化
      ChildComponent({ name:'张三',count: this.goldCount }) //有绑定
      ChildComponent({ name:'李四',count: this.goldCount, cost: 2 }) //有绑定
      ChildComponent({ name:'王五',count: 100, cost: 5 }) //没有绑定
    }.backgroundColor(0xeeeeee)
    .width('100%')
  }
}

@Component
struct ChildComponent {
  @Prop count: number      // 由@Prop装饰的变量
  @Prop name : string
  private cost: number = 1 // 普通成员变量

  build() {
    Row() {
      if (this.count > 0) {
        Text(` ${this.name} 剩余金币：${this.count} 个  `)
      } else {
        Text('已用完！')
      }

      Button() {
        Text(`点击消费 ${this.cost} 金币`)
      }.padding(10)
      .onClick(() => { // 点击响应
        this.count -= this.cost
      })
    }.backgroundColor(0xbbbbbb)
    .width("90%")
    .margin(5).padding(10)
  }
}