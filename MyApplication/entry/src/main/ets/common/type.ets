import { util } from '@kit.ArkTS';
export  class User {
  // 唯一的key,利用了系统工具生产uuid,确保List中条目可区分
  key: string = util.generateRandomUUID(true);
  icon: Resource;
  name: string;
  constructor(name: string, icon: Resource) {
    this.icon = icon;
    this.name = name;
  }
}