
/*
@Entry
@Component
struct LayoutComponent {

  //行排列
  */
/*build() {
    Column({ space: 2 }) {
      Row({ space: 30 }) {
        Text('文本子组件').backgroundColor(0xffff00).fontSize(20)
        Button('按钮').width(220)
      }.width('90%').height(90).border({ width: 1 }).margin(10)

      Row() {
        Text('文本子组件').backgroundColor(0xffff00).fontSize(20)
        Button('按钮').width(100)
      }.border({ width: 1 }).margin(10)

      Row() {
        Text('文本子组件').backgroundColor(0xffff00).fontSize(20)
        Button('按钮').width(100)
      }.width('90%').height(90).border({ width: 1 }).margin(10)
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Center)

      Row() {
        Row().width('30%').height(50).backgroundColor(0xFF0000)
        Row().width('30%').height(50).backgroundColor(0x00FF00)
      }
      .width('90%')
      .height(90)
      .border({ width: 1 })
      .margin(10)
      .justifyContent(FlexAlign.Center)

      Row() {
        Row().width('30%').height(50).backgroundColor(0xFF0000)
        Row().width('30%').height(50).backgroundColor(0x00FF00)
      }
      .width('90%')
      .height(90)
      .border({ width: 1 })
      .margin(10)
      .justifyContent(FlexAlign.SpaceEvenly)

      Row() {
        Row().width('30%').height(50).backgroundColor(0xFF0000)
        Row().width('30%').height(50).backgroundColor(0x00FF00)
      }.width('90%').height(90).border({ width: 1 }).margin(10)
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Row().width('30%').height(50).backgroundColor(0xFF0000)
        Row().width('30%').height(50).backgroundColor(0x00FF00)
      }.width('90%').height(100).border({ width: 1 }).margin(10)
      .justifyContent(FlexAlign.SpaceBetween)
    }.width('100%')
  }*//*

  */
/*build() {
    Column() {
      Column() {
        Text('第一个组件').backgroundColor(0xffff00).fontSize(20)
        Button('按钮').width(100)
      }.width('90%').height(120).border({ width: 1 }).margin(10)

      Column() {

      }
    }.width('100%')
  }*//*


  //列排列
  */
/*build() {
    Column({ space: 1} ) {
      Column({ space: 2}) {
        Text('文本子组件').backgroundColor(0xffff00).fontSize(20)
        Button('按钮').width(100)
      }.width('90%').height(120).border({ width: 1 }).margin(10)

      Column() {
        Text('文本子组件').backgroundColor(0xffff00).fontSize(20)
        Button('按钮').width(100)
      }.border({ width: 1 }).margin(10)

      Column() {
        Text('文本子组件').backgroundColor(0xffff00).fontSize(20)
        Button('按钮').width(100)
      }.width('90%').height(160).border({ width: 1 }).margin(10)
      .alignItems( HorizontalAlign.End)
      .justifyContent(FlexAlign.End)

      Column() {
        Row().width('30%').height(50).backgroundColor(0xFF0000)
        Row().width('30%').height(50).backgroundColor(0x00FF00)
      }.width('90%').height(200).border({ width: 1 }).margin(10)
      .justifyContent(FlexAlign.SpaceAround)
    }.width('100%')
  }*//*


  //堆叠布局
  build() {
    Stack({ alignContent: Alignment.Center }) { //堆叠布局
      Text('第一层').width('90%').height('90%')
        .backgroundColor(0xFFEEEE).align(Alignment.TopStart)
      Text('第二层').width('70%').height('70%')
        .backgroundColor(0xEEFFEE).align(Alignment.TopStart)
      Text('第三层').width('50%').height('50%')
        .backgroundColor(0xEEEEFF).align(Alignment.TopStart)
    }
    .width('100%')
    .height(100)
  }
}
*/

//Flex布局用例
/*@Entry
@Component
struct Layout {
  @State private curArr: string[] = ["HarmonyOS", "鸿蒙",
    "C语言", "C++", "Java", "TypeScript"]
  build() {
    Column() {
      MyKeyInput({ arr: $curArr })
      Text('设定的关键字').fontSize(16).margin(10)
      MyKeyContainer({ arr: $curArr })
    }
  }
}

@Component
struct MyKeyInput {
  @Link arr: string[]
  @State private curInput: string = ''

  build() {
    Flex({ alignItems: ItemAlign.Center }) { // 弹性布局
      TextInput({ placeholder: '请输入新关键字...',
        text: this.curInput })
        .height(50)
        .layoutWeight(8)
        .borderRadius('20px')
        .onChange((value: string) => {
          this.curInput = value
        })

      Button({ type: ButtonType.Capsule, stateEffect: false }) {
        Text('添加').fontSize(18).height(40)
      }.layoutWeight(2)
      .onClick(() => {
        if (this.curInput!=null && this.curInput.length>0) {
          this.arr.unshift(this.curInput)
          this.curInput = ''
        }
      })
    }.padding(10).margin(10)
    .backgroundColor(0xF8F8F8)
  }
}

@Component
struct MyKeyContainer {
  @Link arr: string[]

  build() {
    Flex({ justifyContent: FlexAlign.Start,
      wrap: FlexWrap.Wrap }) { // 弹性布局
      if (this.arr.length > 0) {
        ForEach(this.arr, // 循环渲染
          (item: string) => {
            Text(`${item}`)
              .fontSize(18)
              .backgroundColor(0xCCCCCC)
              .borderRadius('60px')
              .padding(12)
          },
          (item: string) => item.toString()
        )
      }
    }.padding(10).margin(10)
    .backgroundColor(0xF8F8F8)
  }
}*/

//List用法
import { usersData } from '../common/data'
import { User } from '../common/type'

@Entry
@Component
struct Layout {
  @State users: User[] = usersData

  @Builder
  itemEnd(index: number) {
    // 构建尾端滑出组件
    Text("删除")
      .width(60)
      .height(60)
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Red)
      .onClick(() => {
        // 删除当前用户
        this.users.splice(index, 1)
      })
  }

  build() {
    List({ initialIndex: 0, space: 10 }) {
      // 循环渲染ListItem
      ForEach(this.users,
        (item: User, index: number) => {
          ListItem() {
            // 每行一个user, 包括图标和姓名
            Row() {
              Image(item.icon).height(70).width("25%")
              Text(item.name)
                .layoutWeight(1)
                .height(70)
                .fontSize(18)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .margin('3%')
                .backgroundColor(0xDDEEFF)
            }.padding(2).width("100%")
          }
          .swipeAction({
            // 设置左右滑动功能
            end: {
              // end用于设置左滑显示,start设置右滑
              builder: () => { // 构建滑入时显示显示内容
                this.itemEnd(index)
              }
            }
          })
          .width("90%")
          .backgroundColor(0xFFFFFF)
          .padding(2)
          .borderRadius(10)
        },
        // 列表条目的key生成器
        (item: User) => JSON.stringify(item.key))
    }
    .divider({
      strokeWidth: 2,
      color: 0xDDDDDD,
      startMargin: 10,
      endMargin: 10
    }) // 分割线
    .edgeEffect(EdgeEffect.Spring) // 滑动到边缘的效果
    .chainAnimation(false) // 联动特效关闭,打开类似弹簧效果
    .onScrollIndex((firstIndex: number,
      lastIndex: number) => { // 滑动时回调
      console.log('first' + firstIndex) //输出提示信息
      console.log('last' + lastIndex) //输出提示信息
    })
    .margin({ top: 5, left: 10, right: 10 })
  }
}



