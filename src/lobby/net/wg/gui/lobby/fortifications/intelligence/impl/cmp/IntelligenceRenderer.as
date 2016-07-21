package net.wg.gui.lobby.fortifications.intelligence.impl.cmp {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.data.IntelligenceRendererVO;

import scaleform.clik.constants.InvalidationType;

public class IntelligenceRenderer extends TableRenderer {

    public var levelIcon:UILoaderAlt;

    public var timeTF:TextField;

    public var buildingsTF:TextField;

    public var clanTag:TextField;

    public var bookmarkIcon:Sprite;

    public function IntelligenceRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        this.data = param1;
        invalidateData();
        var _loc2_:Point = new Point(mouseX, mouseY);
        _loc2_ = this.localToGlobal(_loc2_);
        if (enabled && this.hitTestPoint(_loc2_.x, _loc2_.y, true)) {
            setState("over");
            this.showTooltip();
        }
    }

    override protected function draw():void {
        var _loc1_:IntelligenceRendererVO = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = IntelligenceRendererVO(data);
            if (_loc1_) {
                this.visible = true;
                this.levelIcon.source = _loc1_.levelIcon;
                this.timeTF.htmlText = _loc1_.defenceTime;
                this.buildingsTF.htmlText = _loc1_.avgBuildingLvl.toFixed(1);
                this.clanTag.htmlText = _loc1_.clanTag;
                this.bookmarkIcon.visible = _loc1_.isFavorite;
            }
            else {
                this.visible = false;
            }
        }
    }

    override protected function onDispose():void {
        this.levelIcon.dispose();
        this.levelIcon = null;
        this.timeTF = null;
        this.buildingsTF = null;
        this.bookmarkIcon = null;
        this.clanTag = null;
        super.onDispose();
    }

    private function showTooltip():void {
        var _loc1_:IntelligenceRendererVO = IntelligenceRendererVO(data);
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_INFO, null, _loc1_.clanID);
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this.showTooltip();
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
        super.handleMouseRollOut(param1);
    }
}
}
