import { preferences } from '@kit.ArkData';
import { TimeCapsule, CapsuleStatus } from './DataModel';

const STORE_NAME = 'timeCapsule';
const PREF_KEY = 'time_capsules';

/**
 * 存储管理器
 */
export class StorageManager {
  private static instance: StorageManager;
  private context: ESObject | null = null;

  public static getInstance(): StorageManager {
    if (!StorageManager.instance) {
      StorageManager.instance = new StorageManager();
    }
    return StorageManager.instance;
  }

  public setContext(context: ESObject): void {
    this.context = context;
  }

  /**
   * 获取所有胶囊
   */
  async getAllCapsules(): Promise<TimeCapsule[]> {
    try {
      if (!this.context) {
        console.error('Context not set');
        return [];
      }
      const dataPreferences = await preferences.getPreferences(this.context, STORE_NAME);
      const data = await dataPreferences.get(PREF_KEY, '[]');
      const capsules: TimeCapsule[] = JSON.parse(data as string);
      
      // 更新胶囊状态并补齐数据
      const now = Date.now();
      return capsules.map(item => {
        const capsule = new TimeCapsule(item);
        if (!capsule.mediaList) {
          capsule.mediaList = [];
        }
        if (capsule.openTime > 0 && capsule.openTime <= now && capsule.status === CapsuleStatus.SENT) {
          capsule.status = CapsuleStatus.OPENED;
        }
        return capsule;
      });
    } catch (err) {
      console.error('获取胶囊失败:', err);
      return [];
    }
  }

  /**
   * 保存胶囊
   */
  async saveCapsule(capsule: TimeCapsule): Promise<boolean> {
    try {
      if (!this.context) {
        console.error('Context not set');
        return false;
      }
      const capsules = await this.getAllCapsules();
      const index = capsules.findIndex(c => c.id === capsule.id);
      
      if (index >= 0) {
        capsules[index] = capsule;
      } else {
        capsules.push(capsule);
      }

      const dataPreferences = await preferences.getPreferences(this.context, STORE_NAME);
      await dataPreferences.put(PREF_KEY, JSON.stringify(capsules));
      await dataPreferences.flush();
      
      return true;
    } catch (err) {
      console.error('保存胶囊失败:', err);
      return false;
    }
  }

  /**
   * 删除胶囊
   */
  async deleteCapsule(id: string): Promise<boolean> {
    try {
      if (!this.context) {
        console.error('Context not set');
        return false;
      }
      const capsules = await this.getAllCapsules();
      const filtered = capsules.filter(c => c.id !== id);
      
      const dataPreferences = await preferences.getPreferences(this.context, STORE_NAME);
      await dataPreferences.put(PREF_KEY, JSON.stringify(filtered));
      await dataPreferences.flush();
      
      return true;
    } catch (err) {
      console.error('删除胶囊失败:', err);
      return false;
    }
  }

  /**
   * 根据ID获取胶囊
   */
  async getCapsuleById(id: string): Promise<TimeCapsule | null> {
    try {
      const capsules = await this.getAllCapsules();
      return capsules.find(c => c.id === id) || null;
    } catch (err) {
      console.error('获取胶囊失败:', err);
      return null;
    }
  }

  /**
   * 根据状态获取胶囊
   */
  async getCapsulesByStatus(status: CapsuleStatus): Promise<TimeCapsule[]> {
    try {
      const capsules = await this.getAllCapsules();
      return capsules.filter(c => c.status === status);
    } catch (err) {
      console.error('获取胶囊失败:', err);
      return [];
    }
  }
}

