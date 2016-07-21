package net.wg.gui.lobby.tankman {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.UILoaderAlt;

import scaleform.clik.events.ButtonEvent;

public class PersonalCaseSkillsItemRenderer extends SoundListItemRenderer {

    public static const SKILL_DOUBLE_CLICK:String = "skillDoubleClick";

    public var clickArea:MovieClip;

    public var icon:UILoaderAlt;

    public var rank:SkillsItemsRendererRankIcon;

    public var _name:TextField;

    public var desc:TextField;

    private var isHeader:Boolean = false;

    private const UPDATE_DATA:String = "updateData";

    private var isData:Boolean = false;

    public var focusIndicatorUI:MovieClip;

    public function PersonalCaseSkillsItemRenderer() {
        super();
        soundType = SoundTypes.RNDR_NORMAL;
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.showTooltip);
        removeEventListener(MouseEvent.ROLL_OUT, this.hideTooltip);
        if (this.icon) {
            this.icon.dispose();
        }
        if (this.rank) {
            this.rank.dispose();
        }
        super.onDispose();
    }

    override protected function configUI():void {
        buttonMode = true;
        allowDeselect = false;
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.showTooltip);
        addEventListener(MouseEvent.ROLL_OUT, this.hideTooltip);
    }

    public function showTooltip(param1:MouseEvent = null):void {
        if (!this.isHeader) {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_SKILL, null, data.title, data.tankmanID);
        }
        else {
            App.toolTipMgr.hide();
        }
    }

    public function hideTooltip(param1:MouseEvent = null):void {
        if (!this.isHeader) {
            App.toolTipMgr.hide();
        }
    }

    public function onSelect(param1:ButtonEvent):void {
        if (!this.isHeader) {
            App.toolTipMgr.hide();
        }
    }

    override public function setData(param1:Object):void {
        if (param1 == null) {
            if (this.visible) {
                this.visible = false;
            }
            return;
        }
        if (!this.visible) {
            this.visible = true;
        }
        super.setData(param1);
        var _loc2_:Point = new Point(mouseX, mouseY);
        _loc2_ = this.localToGlobal(_loc2_);
        if (this.hitTestPoint(_loc2_.x, _loc2_.y, true) && !this.isHeader) {
            setState("over");
            App.utils.scheduler.scheduleTask(this.showTooltip, 100);
        }
        else {
            if (param1.isHeader) {
                setState("disabled");
            }
            this.hideTooltip();
        }
        this.initVisibleElements();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(this.UPDATE_DATA) && this.isData) {
            this.updateData();
        }
    }

    private function updateData():void {
        var _loc1_:* = null;
        if (this.isHeader) {
            this._name.text = App.utils.toUpperOrLowerCase(App.utils.locale.makeString("#dialogs:addSkillWindow/label/" + data.title), true);
            this.desc.text = data.rankId == "common" || data.selfSkill ? "" : "#item_types:tankman/Skill_not_be_used";
            this.rank.visible = false;
        }
        else {
            this.addEventListener(MouseEvent.DOUBLE_CLICK, this.doubleClickHandler);
            this._name.text = data.name;
            this.desc.visible = true;
            this.desc.text = data.desc;
            if (data.title == "common") {
                this.rank.visible = false;
            }
            else if (data.rankId != "common") {
                this.rank.visible = true;
                this.rank.gotoAndStop(!!data.enabled ? "enabled" : "disabled");
                _loc1_ = "../maps/icons/tankmen/roles/small/" + data.rankId + ".png";
                this.rank.setData(_loc1_, data.enabled);
                this.rank.validateNow();
            }
            else {
                this.rank.visible = false;
            }
        }
        this.isData = false;
    }

    private function initVisibleElements():void {
        var _loc1_:* = null;
        this.isHeader = data.isHeader;
        if (data.isHeader) {
            enabled = false;
        }
        if (!this.isHeader) {
            if (!this.icon.visible) {
                this.icon.visible = true;
            }
            _loc1_ = "../maps/icons/tankmen/skills/big/" + data.title + ".png";
            this.icon.source = _loc1_;
        }
        else {
            this.icon.visible = false;
        }
        this.isData = true;
        invalidate(this.UPDATE_DATA);
    }

    private function doubleClickHandler(param1:MouseEvent):void {
        if (App.utils.commons.isLeftButton(param1)) {
            dispatchEvent(new Event(SKILL_DOUBLE_CLICK, true));
        }
    }
}
}
