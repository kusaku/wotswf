package net.wg.gui.cyberSport.views.unit {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.LineDescrIconText;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.controls.CSRallyInfo;
import net.wg.gui.cyberSport.vo.CSIndicatorData;
import net.wg.gui.cyberSport.vo.CSStaticRallyVO;
import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
import net.wg.gui.rally.views.list.AbtractRallyDetailsSection;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class StaticRallyDetailsSection extends AbtractRallyDetailsSection implements IViewStackContent, IStaticRallyDetailsSection {

    public var rallyInfo:CSRallyInfo = null;

    public var battlesCount:LineDescrIconText = null;

    public var winsPercent:LineDescrIconText = null;

    public var ladderIcon:UILoaderAlt = null;

    public var ladderInfoTF:TextField = null;

    public var noAwardsTF:TextField = null;

    public var medalsList:BattleResultsMedalsList = null;

    public var back:MovieClip = null;

    private var _data:CSStaticRallyVO = null;

    public function StaticRallyDetailsSection() {
        super();
        this.rallyInfo.visible = false;
        noRallyScreen.update(CYBERSPORT.WINDOW_STATICRALLYINFO_NORALLYSELECTED);
        joinButton.mouseEnabledOnDisabled = true;
    }

    private static function setIndicatorData(param1:LineDescrIconText, param2:CSIndicatorData):void {
        if (param1 != null && param2 != null) {
            param1.text = param2.value;
            param1.description = param2.description;
            param1.iconSource = param2.iconSource;
            param1.tooltip = param2.tooltip;
            param1.enabled = param2.enabled;
        }
    }

    private static function onLadderIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function isModelAvailable():Boolean {
        return this._data != null;
    }

    override protected function onDispose():void {
        this.ladderIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onLadderIconRollOverHandler);
        this.ladderIcon.removeEventListener(MouseEvent.ROLL_OUT, onLadderIconRollOutHandler);
        this.rallyInfo.dispose();
        this.battlesCount.dispose();
        this.winsPercent.dispose();
        this.ladderIcon.dispose();
        this.medalsList.dispose();
        this.rallyInfo = null;
        this.battlesCount = null;
        this.winsPercent = null;
        this.ladderIcon = null;
        this.ladderInfoTF = null;
        this.medalsList = null;
        this.noAwardsTF = null;
        this.back = null;
        this._data = null;
        super.onDispose();
    }

    override protected function setChangedVisibilityItems():void {
        super.setChangedVisibilityItems();
        addItemsToChangedVisibilityList(this.rallyInfo, this.battlesCount, this.winsPercent, this.ladderIcon, this.ladderInfoTF, this.medalsList, this.noAwardsTF, this.back);
    }

    override protected function draw():void {
        var _loc1_:* = false;
        var _loc2_:* = false;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = false;
            _loc2_ = false;
            if (this._data != null) {
                _loc1_ = this._data.achievementsNumber > 0;
                _loc2_ = !_loc1_;
            }
            this.medalsList.visible = _loc1_;
            this.noAwardsTF.visible = _loc2_;
        }
    }

    override protected function onControlRollOver(param1:Object):void {
    }

    override protected function configUI():void {
        super.configUI();
        this.ladderIcon.addEventListener(MouseEvent.ROLL_OVER, this.onLadderIconRollOverHandler);
        this.ladderIcon.addEventListener(MouseEvent.ROLL_OUT, onLadderIconRollOutHandler);
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function setData(param1:CSStaticRallyVO):void {
        this._data = param1;
        if (param1 != null) {
            this.rallyInfo.setData(param1.rallyInfo);
            this.rallyInfo.visible = true;
            setIndicatorData(this.battlesCount, param1.battlesCount);
            setIndicatorData(this.winsPercent, param1.winsPercent);
            this.ladderIcon.source = param1.ladderIcon;
            this.ladderInfoTF.htmlText = param1.ladderInfo;
            joinInfoTF.htmlText = param1.joinInfo;
            joinButton.enabled = !param1.joinBtnDisabled;
            joinButton.label = param1.joinBtnLabel;
            joinButton.tooltip = param1.joinBtnTooltip;
            if (param1.achievementsNumber > 0) {
                this.medalsList.dataProvider = new DataProvider(param1.achievements);
            }
            else {
                this.noAwardsTF.htmlText = param1.noAwardsText;
            }
        }
        invalidateData();
    }

    public function update(param1:Object):void {
        var _loc2_:CSStaticRallyVO = CSStaticRallyVO(param1);
        this.setData(_loc2_);
    }

    public function updateRallyIcon(param1:String):void {
        this.rallyInfo.updateIcon(param1);
    }

    private function onLadderIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.LADDER, null, this._data.rallyInfo.id);
    }
}
}
