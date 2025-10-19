@Entry
@Component
struct CountdownTimer {
  @State count: number = 10
  @State isRunning: boolean = false
  @State timerId: number = 0
  @State message: string = '准备开始'

  // 启动倒计时
  startCountdown() {
    if (this.isRunning) return

    this.isRunning = true
    this.message = '倒计时中...'

    this.timerId = setInterval(() => {
      if (this.count > 0) {
        this.count--
      } else {
        this.stopCountdown()
        this.message = '时间到！'
      }
    }, 1000)
  }

  // 停止倒计时
  stopCountdown() {
    if (this.timerId) {
      clearInterval(this.timerId)
      this.timerId = 0
    }
    this.isRunning = false
  }

  // 重置倒计时
  resetCountdown() {
    this.stopCountdown()
    this.count = 10
    this.message = '准备开始'
  }

  build() {
    Column() {
      // 标题
      Text('倒计时演示')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40, bottom: 30 })

      // 倒计时显示
      Text(this.count.toString())
        .fontSize(120)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.count <= 3 ? '#ff4500' : '#000000')
        .margin({ bottom: 30 })

      // 状态提示
      Text(this.message)
        .fontSize(20)
        .fontColor('#666666')
        .margin({ bottom: 40 })

      // 按钮区域
      Row() {
        // 开始按钮
        Button(this.isRunning ? '暂停' : '开始')
          .width(120)
          .height(50)
          .backgroundColor(this.isRunning ? '#ffa500' : '#007dff')
          .onClick(() => {
            if (this.isRunning) {
              this.stopCountdown()
              this.message = '已暂停'
            } else {
              this.startCountdown()
            }
          })

        // 重置按钮
        Button('重置')
          .width(120)
          .height(50)
          .margin({ left: 20 })
          .backgroundColor('#36d7b7')
          .onClick(() => {
            this.resetCountdown()
          })
      }
      .margin({ bottom: 50 })

      // 进度指示器
      Progress({ value: this.count, total: 10, style: ProgressStyle.Linear })
        .width('80%')
        .height(20)
        .margin({ bottom: 30 })

      // 说明文本
      Text('点击"开始"按钮启动10秒倒计时\n数字变为红色表示最后3秒')
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .fontColor('#888888')
        .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f0f0f0')
  }

  // 组件销毁时清理定时器
  aboutToDisappear() {
    this.stopCountdown()
  }
}