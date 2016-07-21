package net.wg.gui.lobby.battleResults.components {
import net.wg.data.VO.AchievementItemVO;
import net.wg.data.VO.IconVO;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;

public class CustomAchievement extends SoundListItemRenderer {

    protected static const IMG_URL:String = "img://";

    private static const LOADER_ALPHA:Number = 0.9;

    public var loader:UILoaderAlt;

    public var useBigIcon:Boolean = false;

    protected var achievement:AchievementItemVO;

    private var _dataDirty:Boolean = false;

    public function CustomAchievement() {
        super();
        this.loader.hideLoader = false;
    }

    override public function setData(param1:Object):void {
        if (param1 == null) {
            return;
        }
        super.setData(param1);
        this.achievement = AchievementItemVO(param1);
        this._dataDirty = true;
        this.drawLoader();
    }

    override public function canPlaySound(param1:String):Boolean {
        return false;
    }

    override protected function onDispose():void {
        if (this.loader) {
            this.loader.dispose();
            this.loader.removeEventListener(UILoaderEvent.COMPLETE, this.onLoadCompleteHandler);
            this.loader = null;
        }
        this.achievement = null;
        super.onDispose();
    }

    protected function drawLoader():void {
        var _loc1_:IconVO = null;
        if (this._dataDirty) {
            if (this.achievement.isRare) {
                this.tryToLoadRareAchievement();
            }
            else {
                _loc1_ = this.achievement.icon;
                if (this.loader != null && _loc1_) {
                    this.loader.addEventListener(UILoaderEvent.COMPLETE, this.onLoadCompleteHandler);
                    this.loader.source = !!this.useBigIcon ? _loc1_.big : _loc1_.small;
                }
            }
            this._dataDirty = false;
        }
    }

    protected function tryToLoadRareAchievement():void {
        if (this.achievement.rareIconId) {
            this.loader.source = IMG_URL + this.achievement.rareIconId;
            this.loader.addEventListener(UILoaderEvent.COMPLETE, this.onLoadCompleteHandler);
        }
    }

    protected function onLoadComplete():void {
        this.loader.removeEventListener(UILoaderEvent.COMPLETE, this.onLoadCompleteHandler);
        if (this.achievement.inactive) {
            this.changeSaturation();
        }
    }

    private function changeSaturation():void {
        this.loader.alpha = LOADER_ALPHA;
        App.utils.commons.setSaturation(this.loader, 0);
    }

    private function onLoadCompleteHandler(param1:UILoaderEvent):void {
        this.onLoadComplete();
    }
}
}
