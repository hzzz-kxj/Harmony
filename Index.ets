import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State isImageVisible: boolean = false;

  aboutToAppear() {
    // 根据条件自动跳转到目标页面
    const targetPage = 'Workbench'; // 可以从配置、参数等获取

    setTimeout(() => {
      router.pushUrl({
        url: `pages/${targetPage}`,
        params: { from: 'auto' }
      });
    }, 100);
  }

  build() {
    // 这个页面只显示很短暂的时间，然后就会跳转
    Column() {
      Text('应用启动中...')
        .fontSize(20)
      LoadingProgress()  // 显示加载动画
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }


}
