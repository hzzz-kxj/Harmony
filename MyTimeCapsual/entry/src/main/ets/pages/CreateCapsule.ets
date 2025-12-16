import { TimeCapsule, MoodType, CapsuleStatus, CapsuleMedia, MediaType } from '../model/DataModel';
import { StorageManager } from '../model/StorageManager';
import { MoodSelector } from '../components/MoodSelector';
import { router } from '@kit.ArkUI';
import {
  PhotoViewPicker,
  VideoViewPicker,
  AudioViewPicker,
  PhotoSelectOptions,
  VideoSelectOptions,
  AudioSelectOptions,
  PhotoViewMIMETypes,
  PhotoSelectResult,
  VideoSelectResult,
  AudioSelectResult,
  FilePickerModule
} from '../utils/FilePickerTypes';

// 声明 filepicker 模块（系统模块，运行时可用）
declare function require(moduleName: string): FilePickerModule;

/**
 * 边距值接口
 */
interface MarginValue {
  right?: number;
  left?: number;
  top?: number;
  bottom?: number;
}

/**
 * 创建胶囊页面
 */
@Entry
@Component
struct CreateCapsule {
  @State title: string = '';
  @State content: string = '';
  @State selectedMood: MoodType = MoodType.HAPPY;
  @State openTime: number = Date.now() + 86400000; // 默认明天
  @State showPicker: boolean = false;
  @State mediaList: CapsuleMedia[] = [];
  private storageManager = StorageManager.getInstance();
  
  // 获取 filepicker 模块
  private getFilePickerModule(): FilePickerModule {
    return require('@ohos.filepicker');
  }

  // 辅助函数：创建 PhotoViewPicker 实例
  private createPhotoViewPicker(pickerModule: FilePickerModule): PhotoViewPicker {
    const PickerClass: ESObject = pickerModule.PhotoViewPicker as ESObject;
    const instance: ESObject = new PickerClass() as ESObject;
    return instance as PhotoViewPicker;
  }

  // 辅助函数：创建 PhotoSelectOptions 实例
  private createPhotoSelectOptions(pickerModule: FilePickerModule): PhotoSelectOptions {
    const OptionsClass: ESObject = pickerModule.PhotoSelectOptions as ESObject;
    const instance: ESObject = new OptionsClass() as ESObject;
    return instance as PhotoSelectOptions;
  }

  // 辅助函数：创建 VideoViewPicker 实例
  private createVideoViewPicker(pickerModule: FilePickerModule): VideoViewPicker {
    const PickerClass: ESObject = pickerModule.VideoViewPicker as ESObject;
    const instance: ESObject = new PickerClass() as ESObject;
    return instance as VideoViewPicker;
  }

  // 辅助函数：创建 VideoSelectOptions 实例
  private createVideoSelectOptions(pickerModule: FilePickerModule): VideoSelectOptions {
    const OptionsClass: ESObject = pickerModule.VideoSelectOptions as ESObject;
    const instance: ESObject = new OptionsClass() as ESObject;
    return instance as VideoSelectOptions;
  }

  // 辅助函数：创建 AudioViewPicker 实例
  private createAudioViewPicker(pickerModule: FilePickerModule): AudioViewPicker {
    const PickerClass: ESObject = pickerModule.AudioViewPicker as ESObject;
    const instance: ESObject = new PickerClass() as ESObject;
    return instance as AudioViewPicker;
  }

  // 辅助函数：创建 AudioSelectOptions 实例
  private createAudioSelectOptions(pickerModule: FilePickerModule): AudioSelectOptions {
    const OptionsClass: ESObject = pickerModule.AudioSelectOptions as ESObject;
    const instance: ESObject = new OptionsClass() as ESObject;
    return instance as AudioSelectOptions;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // 标题栏
        Row() {
          Button('取消')
            .fontSize(16)
            .fontColor('#4A90E2')
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              router.back();
            })
          Blank()
          Text('创建时空胶囊')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Blank()
          Button('保存')
            .fontSize(16)
            .fontColor(this.canSave() ? '#4A90E2' : '#CCCCCC')
            .backgroundColor(Color.Transparent)
            .enabled(this.canSave())
            .onClick(() => {
              this.saveCapsule();
            })
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')

        Scroll() {
        Column() {
          // 心情选择
          Column() {
            Text('选择你的心情')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ bottom: 12 })
            MoodSelector({
              selectedMood: this.selectedMood,
              onMoodChange: (mood: MoodType) => {
                this.selectedMood = mood;
              }
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 12 })

          // 标题输入
          Column() {
            Text('标题')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ bottom: 12 })
            TextInput({ placeholder: '给你的胶囊起个标题...' })
              .width('100%')
              .height(48)
              .padding({ left: 12, right: 12 })
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.title = value;
              })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 12 })

          // 内容输入
          Column() {
            Text('内容')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ bottom: 12 })
            TextArea({ placeholder: '写下你想对未来的自己或他人说的话...' })
              .width('100%')
              .height(200)
              .padding(12)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onChange((value: string) => {
                this.content = value;
              })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 12 })

          // 多媒体附件
          Column() {
            Text('多媒体附件')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ bottom: 12 })
            Row() {
              this.mediaActionButton('添加照片', '#FFEDEB', '#FF7A45', 1, this.createMargin(6), () => {
                this.addPhotoAttachment();
              })
              this.mediaActionButton('添加视频', '#E6F7FF', '#1890FF', 1, this.createMargin(6), () => {
                this.addVideoAttachment();
              })
              this.mediaActionButton('添加音频', '#F6FFED', '#52C41A', 1, this.createMargin(), () => {
                this.addAudioAttachment();
              })
            }
            .width('100%')
            .margin({ bottom: 12 })

            if (this.mediaList.length === 0) {
              Text('暂未添加附件，支持照片 / 视频 / 音频')
                .fontSize(13)
                .fontColor('#999999')
                .width('100%')
                .padding({ top: 12, bottom: 8 })
            } else {
              Column() {
                ForEach(this.mediaList, (media: CapsuleMedia) => {
                  this.mediaPreviewItem(media);
                }, (media: CapsuleMedia) => media.id)
              }
              .width('100%')
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 12 })

          // 开启时间
          Column() {
            Text('开启时间')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ bottom: 12 })
            Row() {
              Button(this.formatDate(this.openTime))
                .type(ButtonType.Normal)
                .fontColor('#4A90E2')
                .backgroundColor('#F0F8FF')
                .fontSize(14)
                .padding({ left: 16, right: 16 })
                .onClick(() => {
                  this.showPicker = true;
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
        }
        .width('100%')
        .padding(16)
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // 日期选择器弹窗 - 使用覆盖层
      if (this.showPicker) {
        this.datePickerOverlay()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  datePickerOverlay() {
    // 半透明背景
    Column() {
      // 弹窗内容
      Column() {
        DatePicker({
          start: new Date(Date.now()),
          selected: new Date(this.openTime)
        })
          .onChange((value: DatePickerResult) => {
            const year = value.year as number;
            const month = value.month as number;
            const day = value.day as number;
            this.openTime = new Date(year, month - 1, day).getTime();
          })
        Row() {
          Button('取消')
            .type(ButtonType.Normal)
            .fontColor('#666666')
            .backgroundColor('#F5F5F5')
            .layoutWeight(1)
            .height(44)
            .borderRadius(8)
            .onClick(() => {
              this.showPicker = false;
            })
            .margin({ right: 8 })
          Button('确定')
            .type(ButtonType.Normal)
            .fontColor('#FFFFFF')
            .backgroundColor('#4A90E2')
            .layoutWeight(1)
            .height(44)
            .borderRadius(8)
            .onClick(() => {
              this.showPicker = false;
            })
            .margin({ left: 8 })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('90%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({
        radius: 16,
        color: '#40000000',
        offsetX: 0,
        offsetY: 4
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#40000000')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.showPicker = false;
    })
  }

  formatDate(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  canSave(): boolean {
    return this.content.trim().length > 0 || this.mediaList.length > 0;
  }

  createMargin(right?: number, left?: number, top?: number, bottom?: number): MarginValue {
    const margin: MarginValue = {};
    if (right !== undefined) margin.right = right;
    if (left !== undefined) margin.left = left;
    if (top !== undefined) margin.top = top;
    if (bottom !== undefined) margin.bottom = bottom;
    return margin;
  }

  async saveCapsule() {
    const capsule = new TimeCapsule();
    capsule.id = TimeCapsule.generateId();
    capsule.title = this.title.trim();
    capsule.content = this.content.trim();
    capsule.mood = this.selectedMood;
    capsule.openTime = this.openTime;
    capsule.status = CapsuleStatus.SENT;
    capsule.createTime = Date.now();
    capsule.mediaList = this.mediaList.map((item: CapsuleMedia) => {
      const media: CapsuleMedia = {
        id: item.id,
        type: item.type,
        uri: item.uri,
        name: item.name,
        duration: item.duration,
        size: item.size
      };
      return media;
    });

    const success = await this.storageManager.saveCapsule(capsule);
    if (success) {
      router.back();
    }
  }

  @Builder
  mediaActionButton(label: string, bgColor: string, textColor: string, weight: number, marginValue: MarginValue, onClick: () => void) {
    Button(label)
      .height(40)
      .backgroundColor(bgColor)
      .fontColor(textColor)
      .fontSize(14)
      .borderRadius(8)
      .layoutWeight(weight)
      .margin(marginValue)
      .onClick(onClick)
  }

  @Builder
  mediaPreviewItem(media: CapsuleMedia) {
    Row() {
      Column() {
        this.mediaIcon(media)
      }
      .margin({ right: 12 })
      Column() {
        Text(this.getMediaTitle(media))
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 4 })
        Text(this.getMediaTypeLabel(media.type))
          .fontSize(12)
          .fontColor('#999999')
      }
      .layoutWeight(1)
      Button('移除')
        .height(32)
        .backgroundColor('#FFEFEF')
        .fontColor('#FF4D4F')
        .fontSize(12)
        .borderRadius(16)
        .onClick(() => {
          this.removeMedia(media.id);
        })
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
  }

  @Builder
  mediaIcon(media: CapsuleMedia) {
    if (media.type === MediaType.PHOTO) {
      Image(media.uri)
        .width(48)
        .height(48)
        .borderRadius(8)
        .backgroundColor('#FFF')
        .objectFit(ImageFit.Cover)
    } else if (media.type === MediaType.VIDEO) {
      Text('🎬')
        .fontSize(36)
    } else {
      Text('🎧')
        .fontSize(36)
    }
  }

  getMediaTypeLabel(type: MediaType): string {
    switch (type) {
      case MediaType.PHOTO:
        return '照片附件';
      case MediaType.VIDEO:
        return '视频附件';
      case MediaType.AUDIO:
        return '音频附件';
      default:
        return '附件';
    }
  }

  getMediaTitle(media: CapsuleMedia): string {
    if (media.name && media.name.length > 0) {
      return media.name;
    }
    return this.extractNameFromUri(media.uri);
  }

  extractNameFromUri(uri: string): string {
    if (!uri) {
      return '附件';
    }
    const parts = uri.split('/');
    const last = parts[parts.length - 1];
    return last && last.length > 0 ? last : '附件';
  }

  removeMedia(id: string) {
    this.mediaList = this.mediaList.filter(item => item.id !== id);
  }

  async addPhotoAttachment() {
    try {
      const pickerModule = this.getFilePickerModule();
      const photoPicker = this.createPhotoViewPicker(pickerModule);
      const options = this.createPhotoSelectOptions(pickerModule);
      options.MIMEType = pickerModule.PhotoViewMIMETypes.IMAGE_TYPE;
      options.maxSelectNumber = 3;
      const result: PhotoSelectResult = await photoPicker.select(options);
      const uris: string[] = (result?.photoUris ?? result?.uris ?? []) as string[];
      const names: string[] | undefined = (result?.photoNames ?? result?.names) as string[] | undefined;
      this.appendMediaFromUris(MediaType.PHOTO, uris, names);
    } catch (err) {
      console.error('选择照片失败:', err);
    }
  }

  async addVideoAttachment() {
    try {
      const pickerModule = this.getFilePickerModule();
      const videoPicker = this.createVideoViewPicker(pickerModule);
      const options = this.createVideoSelectOptions(pickerModule);
      options.maxSelectNumber = 2;
      const result: VideoSelectResult = await videoPicker.select(options);
      const uris: string[] = (result?.videoUris ?? result?.uris ?? []) as string[];
      const names: string[] | undefined = (result?.videoNames ?? result?.names) as string[] | undefined;
      this.appendMediaFromUris(MediaType.VIDEO, uris, names);
    } catch (err) {
      console.error('选择视频失败:', err);
    }
  }

  async addAudioAttachment() {
    try {
      const pickerModule = this.getFilePickerModule();
      const audioPicker = this.createAudioViewPicker(pickerModule);
      const options = this.createAudioSelectOptions(pickerModule);
      options.maxSelectNumber = 2;
      const result: AudioSelectResult = await audioPicker.select(options);
      const uris: string[] = (result?.audioUris ?? result?.uris ?? []) as string[];
      const names: string[] | undefined = (result?.audioNames ?? result?.names) as string[] | undefined;
      this.appendMediaFromUris(MediaType.AUDIO, uris, names);
    } catch (err) {
      console.error('选择音频失败:', err);
    }
  }

  appendMediaFromUris(type: MediaType, uris: string[], names?: string[]) {
    if (!uris || uris.length === 0) {
      return;
    }
    const appended = uris.map((uri: string, index: number) => {
      const media: CapsuleMedia = {
        id: TimeCapsule.generateId(),
        type: type,
        uri: uri,
        name: names && names[index] ? names[index] : this.extractNameFromUri(uri)
      };
      return media;
    });
    this.mediaList = [...this.mediaList, ...appended];
  }
}

