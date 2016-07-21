package net.wg.gui.lobby.fortifications.settings.impl {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.fortifications.cmp.tankIcon.impl.FortTankIcon;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsConditionsBlockVO;
import net.wg.gui.lobby.fortifications.popovers.impl.PopoverBuildingTexture;
import net.wg.infrastructure.interfaces.ISpriteEx;

public class FortSettingsConditionsBlock extends Sprite implements ISpriteEx {

    private static const LOADERS_NUMBER:int = 2;

    public var startLvlLoader:UILoaderAlt = null;

    public var endLvlLoader:UILoaderAlt = null;

    public var buildingIcon:PopoverBuildingTexture = null;

    public var lvlDashTF:TextField = null;

    public var defenceTankIcon:FortTankIcon = null;

    public var attackTankIconTop:FortTankIcon = null;

    public var attackTankIconBottom:FortTankIcon = null;

    private var _loaded:int = 0;

    public function FortSettingsConditionsBlock() {
        super();
        this.startLvlLoader.visible = false;
        this.endLvlLoader.visible = false;
        this.startLvlLoader.autoSize = false;
        this.endLvlLoader.autoSize = false;
        this.lvlDashTF.autoSize = TextFieldAutoSize.LEFT;
    }

    public function update(param1:Object):void {
        var _loc2_:FortSettingsConditionsBlockVO = FortSettingsConditionsBlockVO(param1);
        this.buildingIcon.setState(_loc2_.buildingIcon);
        this.lvlDashTF.htmlText = _loc2_.lvlDashTF;
        this.defenceTankIcon.update(_loc2_.defenceTankIcon);
        this.attackTankIconTop.update(_loc2_.attackTankIconTop);
        this.attackTankIconBottom.update(_loc2_.attackTankIconBottom);
        this.startLvlLoader.source = _loc2_.startLvlSrc;
        this.endLvlLoader.source = _loc2_.endLvlSrc;
        this.startLvlLoader.addEventListener(UILoaderEvent.COMPLETE, this.onLvlLoadCompleteHandler);
        this.endLvlLoader.addEventListener(UILoaderEvent.COMPLETE, this.onLvlLoadCompleteHandler);
        this.setLevelsPosition();
    }

    private function setLevelsPosition():void {
        this.lvlDashTF.x = Math.round(this.startLvlLoader.x + this.startLvlLoader.width);
        this.endLvlLoader.x = Math.round(this.lvlDashTF.x + this.lvlDashTF.width);
        this.startLvlLoader.visible = true;
        this.endLvlLoader.visible = true;
    }

    public function dispose():void {
        this.startLvlLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onLvlLoadCompleteHandler);
        this.endLvlLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onLvlLoadCompleteHandler);
        this.buildingIcon.dispose();
        this.buildingIcon = null;
        this.defenceTankIcon.dispose();
        this.attackTankIconTop.dispose();
        this.attackTankIconBottom.dispose();
        this.defenceTankIcon = null;
        this.attackTankIconTop = null;
        this.attackTankIconBottom = null;
        this.startLvlLoader.dispose();
        this.endLvlLoader.dispose();
        this.startLvlLoader = null;
        this.endLvlLoader = null;
    }

    private function onLvlLoadCompleteHandler(param1:UILoaderEvent):void {
        param1.target.removeEventListener(UILoaderEvent.COMPLETE, this.onLvlLoadCompleteHandler);
        this._loaded++;
        if (this._loaded >= LOADERS_NUMBER) {
            this.setLevelsPosition();
        }
    }
}
}
