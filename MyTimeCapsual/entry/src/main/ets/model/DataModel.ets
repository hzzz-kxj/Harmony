/**
 * 时空胶囊数据模型
 */

// 胶囊状态枚举
export enum CapsuleStatus {
  DRAFT = 'draft',        // 草稿
  SENT = 'sent',          // 已发送（等待开启）
  OPENED = 'opened',      // 已开启
  EXPIRED = 'expired'     // 已过期
}

export enum MediaType {
  PHOTO = 'photo',
  VIDEO = 'video',
  AUDIO = 'audio'
}

export interface CapsuleMedia {
  id: string;
  type: MediaType;
  uri: string;
  name?: string;
  duration?: number;
  size?: number;
}

// 心情类型
export enum MoodType {
  HAPPY = 'happy',
  SAD = 'sad',
  PEACEFUL = 'peaceful',
  EXCITED = 'excited',
  NOSTALGIC = 'nostalgic',
  LOVE = 'love'
}

// 时空胶囊数据模型
export class TimeCapsule {
  id: string = '';
  title: string = '';
  content: string = '';
  createTime: number = Date.now();
  openTime: number = 0;
  mood: MoodType = MoodType.HAPPY;
  status: CapsuleStatus = CapsuleStatus.DRAFT;
  recipient: string = ''; // 收件人，空表示给自己
  isPublic: boolean = false; // 是否公开
  mediaList: CapsuleMedia[] = [];

  constructor(data?: Partial<TimeCapsule>) {
    if (data) {
      if (data.id !== undefined) this.id = data.id;
      if (data.title !== undefined) this.title = data.title;
      if (data.content !== undefined) this.content = data.content;
      if (data.createTime !== undefined) this.createTime = data.createTime;
      if (data.openTime !== undefined) this.openTime = data.openTime;
      if (data.mood !== undefined) this.mood = data.mood;
      if (data.status !== undefined) this.status = data.status;
      if (data.recipient !== undefined) this.recipient = data.recipient;
      if (data.isPublic !== undefined) this.isPublic = data.isPublic;
      if (data.mediaList !== undefined && Array.isArray(data.mediaList)) {
        this.mediaList = data.mediaList.map((item: CapsuleMedia) => {
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
      }
    }
    if (!this.mediaList) {
      this.mediaList = [];
    }
  }

  // 生成唯一ID
  static generateId(): string {
    const timestamp = new Date().getTime();
    const randomStr = TimeCapsule.generateRandomString(9);
    return timestamp.toString() + randomStr;
  }

  static generateRandomString(length: number): string {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    for (let i = 0; i < length; i++) {
      result += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return result;
  }
}

