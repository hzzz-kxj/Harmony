interface GeneratedTypeLiteralInterface_1 {
  id: number;
  name: string;
  icon: string;
  bgColor: string;
}

interface GeneratedTypeLiteralInterface_2 {
  id: number;
  name: string;
  icon: string;
  bgColor: string;
}

@Entry
@Component
struct Workbench {
  // 工作台应用数据
  @State apps: Array<GeneratedTypeLiteralInterface_1> = [
    { id: 1, name: '迎新服务', icon: '🎓', bgColor: '#FF6B6B' },
    { id: 2, name: '一网通办', icon: '🌐', bgColor: '#4ECDC4' },
    { id: 3, name: '我的课表', icon: '📚', bgColor: '#45B7D1' },
    { id: 4, name: '校务', icon: '🏫', bgColor: '#96CEB4' },
    { id: 5, name: 'UClass', icon: '💻', bgColor: '#FECA57' },
    { id: 6, name: '志愿服务', icon: '❤️', bgColor: '#FF9FF3' },
    { id: 7, name: '心理服务', icon: '🧠', bgColor: '#54A0FF' },
    { id: 8, name: '接龙管家', icon: '📝', bgColor: '#5F27CD' },
    { id: 9, name: '群发助手', icon: '📢', bgColor: '#00D2D3' },
    { id: 10, name: '党办', icon: '⭐', bgColor: '#FF9F43' },
    { id: 11, name: '宣传部', icon: '📣', bgColor: '#FF7979' },
    { id: 12, name: '财务处', icon: '💰', bgColor: '#10AC84' },
    { id: 13, name: '档案馆', icon: '📁', bgColor: '#8395A7' },
    { id: 14, name: '学工处', icon: '👨‍🎓', bgColor: '#A3CB38' },
    { id: 15, name: '教务处', icon: '📊', bgColor: '#FD7272' },
    { id: 16, name: '后勤处', icon: '🏠', bgColor: '#9AECDB' }
  ]


  build() {
    Column() {
      // 顶部状态栏区域
      //this.buildStatusBar()

      // 工作台标题
      this.buildHeader()

      // 应用网格
      this.buildAppGrid()

      // 底部导航栏
      this.buildTabBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  /*// 构建状态栏
  @Builder buildStatusBar() {
    Row() {
      Text('5G')
        .fontSize(12)
        .fontColor('#000000')

      Text('8:22')
        .fontSize(16)
        .fontColor('#000000')
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })

      Blank()

      Text('📶')  // 信号图标
        .fontSize(16)
        .margin({ right: 12 })

      Text('🔋')  // 电池图标
        .fontSize(16)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
  }*/

  // 构建头部
  @Builder buildHeader() {
    Column() {
      Row() {
        Text('工作台')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Blank()

        // 搜索图标
        Text('🔍')  // 搜索图标
          .fontSize(20)
          .margin({ right: 16 })

        // 更多图标
        Text('⋯')  // 更多图标（三个点）
          .fontSize(24)
          .fontColor('#000000')
      }
      .width('100%')

      // 用户信息栏
      Row() {
        Text('👨‍💼')  // 头像图标
          .fontSize(32)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)

        Column() {
          Text('张三')
            .fontSize(16)
            .fontColor('#000000')
            .fontWeight(FontWeight.Medium)

          Text('企业账号')
            .fontSize(12)
            .fontColor('#666666')
        }
        .margin({ left: 12 })
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('离校')
          .fontSize(14)
          .fontColor('#666666')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#F0F0F0')
          .borderRadius(12)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
  }

  // 构建应用网格
  @Builder buildAppGrid() {
    Scroll() {
      Grid() {
        ForEach(this.apps, (item: GeneratedTypeLiteralInterface_2) => {
          GridItem() {
            Column() {
              // 应用图标
              Text(item.icon)
                .fontSize(24)
                .width(50)
                .height(50)
                .backgroundColor(item.bgColor)
                .borderRadius(10)
                .textAlign(TextAlign.Center)

              // 应用名称
              Text(item.name)
                .fontSize(12)
                .fontColor('#333333')
                .margin({ top: 8 })
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('100%')
            .padding({ top: 16, bottom: 16 })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .onClick(() => {
            console.info(`点击了: ${item.name}`)
          })
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(0)
      .rowsGap(0)
      .width('100%')
      .height(500)
      .margin({ top: 12 })
    }
    .scrollable(ScrollDirection.Vertical)
    .width('100%')
    .flexGrow(1)
  }

  // 构建底部导航栏
  @Builder buildTabBar() {
    Row() {
      // 消息
      Column() {
        Text('💬')  // 消息图标
          .fontSize(20)
        Text('消息')
          .fontSize(10)
          .fontColor('#07C160')  // 绿色选中状态
          .margin({ top: 2 })
      }
      .onClick(() => {
        console.info('点击消息')
      })

      // 文档
      Column() {
        Text('📄')  // 文档图标
          .fontSize(20)
        Text('文档')
          .fontSize(10)
          .fontColor('#666666')
          .margin({ top: 2 })
      }
      .onClick(() => {
        console.info('点击文档')
      })

      // 通讯录
      Column() {
        Text('👥')  // 通讯录图标
          .fontSize(20)
        Text('通讯录')
          .fontSize(10)
          .fontColor('#666666')
          .margin({ top: 2 })
      }
      .onClick(() => {
        console.info('点击通讯录')
      })

      // 工作台
      Column() {
        Text('🏢')  // 工作台图标
          .fontSize(20)
        Text('工作台')
          .fontSize(10)
          .fontColor('#666666')
          .margin({ top: 2 })
      }
      .onClick(() => {
        console.info('点击工作台')
      })
    }
    .width('100%')
    .height(60)
    .padding({ left: 40, right: 40 })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
    .border({ width: { top: 1 }, color: '#EEEEEE' })
  }
}