import { TimeCapsule, MoodType, CapsuleStatus, CapsuleMedia, MediaType } from '../model/DataModel';
import { StorageManager } from '../model/StorageManager';
import { DateUtils } from '../utils/DateUtils';
import { router } from '@kit.ArkUI';

/**
 * 胶囊详情页面
 */
@Entry
@Component
struct CapsuleDetail {
  @State capsule: TimeCapsule | null = null;
  @State loading: boolean = true;
  @State showDeleteConfirm: boolean = false;
  @State deleting: boolean = false;
  @State isUnlocked: boolean = false   // 是否已解锁
  private storageManager = StorageManager.getInstance();
  private capsuleId: string = '';


  aboutToAppear() {
    // 获取路由参数
    const params = router.getParams();
    if (params && typeof params === 'object') {
      const capsuleId = (params as Record<string, Object>)['capsuleId'];
      if (typeof capsuleId === 'string') {
        this.capsuleId = capsuleId;
        this.loadCapsule();
      }
    }
  }

  async loadCapsule() {
    this.loading = true;
    const capsule = await this.storageManager.getCapsuleById(this.capsuleId);
    this.capsule = capsule;
    this.loading = false;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // 标题栏
        Row() {
          Button('←')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              router.back();
            })
          Blank()
          Text('胶囊详情')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          Blank()
          if (!this.loading && this.capsule) {
            Button('删除')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .backgroundColor(Color.Transparent)
              .onClick(() => {
                this.showDeleteConfirm = true;
              })
          } else {
            Text('  ')
              .fontSize(20)
          }
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#4A90E2')

        if (this.loading) {
          Column() {
            LoadingProgress()
              .width(60)
              .height(60)
              .color('#4A90E2')
            Text('加载中...')
              .margin({ top: 12 })
              .fontSize(14)
              .fontColor('#999999')
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        } else if (this.capsule) {
          Scroll() {
            Column() {
              // 心情和标题
              Row() {
                Column() {
                  this.getMoodIcon(this.capsule.mood)
                }
                .width(48)
                .height(48)
                Column() {
                  Text(this.capsule.title || '无标题')
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .margin({ bottom: 4 })
                  Text(DateUtils.formatDateTime(this.capsule.createTime))
                    .fontSize(12)
                    .fontColor('#999999')
                }
                .layoutWeight(1)
                .margin({ left: 12 })
              }
              .width('100%')
              .padding({ top: 24, left: 24, right: 24, bottom: 16 })

              Divider()
                .color('#E0E0E0')
                .margin({ left: 24, right: 24 })

              // 内容
              Text(this.capsule.content)
                .fontSize(16)
                .lineHeight(26)
                .width('100%')
                .margin({ top: 16, left: 24, right: 24 })

              // 时间信息
              Column() {
                Text('时间胶囊信息')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .width('100%')
                  .margin({ bottom: 12 })
                Row() {
                  Text('创建时间：')
                    .fontSize(14)
                    .fontColor('#666666')
                  Blank()
                  Text(DateUtils.formatDateTime(this.capsule.createTime))
                    .fontSize(14)
                    .fontColor('#333333')
                }
                .width('100%')
                .margin({ bottom: 8 })
                
                if (this.capsule.openTime > 0) {
                  Row() {
                    Text('开启时间：')
                      .fontSize(14)
                      .fontColor('#666666')
                    Blank()
                    Text(DateUtils.formatDateTime(this.capsule.openTime))
                      .fontSize(14)
                      .fontColor('#333333')
                  }
                  .width('100%')
                  .margin({ bottom: 8 })

                  Row() {
                    Text('状态：')
                      .fontSize(14)
                      .fontColor('#666666')
                    Blank()
                    Text(this.getStatusText())
                      .fontSize(14)
                      .fontColor(this.getStatusColor())
                  }
                  .width('100%')
                }
              }
              .width('100%')
              .padding(16)
              .margin({ top: 24, left: 16, right: 16, bottom: 24 })
              .backgroundColor('#F5F5F5')
              .borderRadius(12)

              if (this.capsule.mediaList && this.capsule.mediaList.length > 0) {
                Column() {
                  Text('附件')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .width('100%')
                    .margin({ bottom: 12 })
                  Column() {
                    ForEach(this.capsule.mediaList, (media: CapsuleMedia) => {
                      this.detailMediaItem(media);
                    }, (media: CapsuleMedia) => media.id)
                  }
                }
                .width('100%')
                .padding(16)
                .margin({ left: 16, right: 16, bottom: 32 })
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({
                  radius: 12,
                  color: '#08000000',
                  offsetX: 0,
                  offsetY: 2
                })
              }

              Button('删除这个胶囊')
                .width('90%')
                .height(48)
                .margin({ top: 12, bottom: 32 })
                .alignSelf(ItemAlign.Center)
                .backgroundColor('#FF4D4F')
                .fontColor('#FFFFFF')
                .borderRadius(12)
                .onClick(() => {
                  this.showDeleteConfirm = true;
                })
            }
            .width('100%')
          }
          .layoutWeight(1)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      if (this.showDeleteConfirm) {
        this.deleteConfirmDialog()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  getMoodIcon(mood: MoodType) {
    if (mood === MoodType.HAPPY) {
      Text('😊')
    } else if (mood === MoodType.SAD) {
      Text('😢')
    } else if (mood === MoodType.PEACEFUL) {
      Text('😌')
    } else if (mood === MoodType.EXCITED) {
      Text('🤩')
    } else if (mood === MoodType.NOSTALGIC) {
      Text('🥺')
    } else if (mood === MoodType.LOVE) {
      Text('❤️')
    } else {
      Text('😊')
    }
  }

  getStatusText(): string {
    if (!this.capsule) return '';
    switch (this.capsule.status) {
      case CapsuleStatus.DRAFT:
        return '草稿';
      case CapsuleStatus.SENT:
        return '已发送';
      case CapsuleStatus.OPENED:
        return '已开启';
      case CapsuleStatus.EXPIRED:
        return '已过期';
      default:
        return '未知';
    }
  }

  getStatusColor(): string {
    if (!this.capsule) return '#333333';
    switch (this.capsule.status) {
      case CapsuleStatus.SENT:
        return '#4A90E2';
      case CapsuleStatus.OPENED:
        return '#52C41A';
      default:
        return '#333333';
    }
  }

  @Builder
  deleteConfirmDialog() {
    Column() {
      Column() {
        Text('删除胶囊')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 8 })
        Text('删除后不可恢复，确定要删除吗？')
          .fontSize(14)
          .fontColor('#666666')
          .margin({ bottom: 24 })
        Row() {
          Button('取消')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F0F0F0')
            .fontColor('#333333')
            .borderRadius(8)
            .onClick(() => {
              this.showDeleteConfirm = false;
            })
            .margin({ right: 8 })
          Button(this.deleting ? '删除中...' : '删除')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#FF4D4F')
            .fontColor('#FFFFFF')
            .borderRadius(8)
            .enabled(!this.deleting)
            .onClick(() => {
              this.handleDelete();
            })
            .margin({ left: 8 })
        }
        .width('100%')
      }
      .width('80%')
      .padding(24)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({
        radius: 20,
        color: '#40000000',
        offsetX: 0,
        offsetY: 4
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#40000000')
  }

  async handleDelete() {
    if (!this.capsule || this.deleting) {
      return;
    }
    this.deleting = true;
    const success = await this.storageManager.deleteCapsule(this.capsule.id);
    this.deleting = false;
    if (success) {
      this.showDeleteConfirm = false;
      router.back();
    }
  }

  @Builder
  detailMediaItem(media: CapsuleMedia) {
    if (media.type === MediaType.PHOTO) {
      Image(media.uri)
        .width('100%')
        .height(200)
        .borderRadius(12)
        .margin({ bottom: 12 })
        .objectFit(ImageFit.Cover)
    } else {
      Row() {
        Text(media.type === MediaType.VIDEO ? '🎬' : '🎧')
          .fontSize(28)
          .margin({ right: 12 })
        Column() {
          Text(this.getMediaTitle(media))
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 4 })
          Text(media.uri)
            .fontSize(12)
            .fontColor('#999999')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 12, bottom: 12 })
    }
  }

  getMediaTitle(media: CapsuleMedia): string {
    if (media.name && media.name.length > 0) {
      return media.name;
    }
    if (!media.uri) {
      return '附件';
    }
    const parts = media.uri.split('/');
    const last = parts[parts.length - 1];
    return last && last.length > 0 ? last : '附件';
  }
}

