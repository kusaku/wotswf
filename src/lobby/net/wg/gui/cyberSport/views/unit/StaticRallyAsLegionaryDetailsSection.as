package net.wg.gui.cyberSport.views.unit {
import flash.display.InteractiveObject;

import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.controls.CSRallyInfo;
import net.wg.gui.cyberSport.vo.CSStaticLegionaryRallyVO;
import net.wg.gui.rally.BaseRallyMainWindow;
import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.gui.rally.views.list.BaseRallyDetailsSection;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.constants.InvalidationType;

public class StaticRallyAsLegionaryDetailsSection extends BaseRallyDetailsSection implements IViewStackContent, IStaticRallyDetailsSection {

    public var slot0:RallySimpleSlotRenderer;

    public var slot1:RallySimpleSlotRenderer;

    public var slot2:RallySimpleSlotRenderer;

    public var slot3:RallySimpleSlotRenderer;

    public var slot4:RallySimpleSlotRenderer;

    public var slot5:RallySimpleSlotRenderer;

    public var slot6:RallySimpleSlotRenderer;

    public var rallyInfo:CSRallyInfo;

    private var _slots:Vector.<IRallySimpleSlotRenderer>;

    public function StaticRallyAsLegionaryDetailsSection() {
        super();
    }

    override public function setData(param1:IRallyVO):void {
        var _loc2_:CSStaticLegionaryRallyVO = null;
        super.setData(param1);
        _loc2_ = param1 as CSStaticLegionaryRallyVO;
        if (_loc2_ != null) {
            this.rallyInfo.visible = true;
            this.rallyInfo.setData(_loc2_.rallyInfo);
            joinInfoTF.htmlText = _loc2_.joinInfo;
            joinButton.label = _loc2_.joinBtnLabel;
            joinButton.tooltip = _loc2_.joinBtnTooltip;
        }
    }

    override protected function setChangedVisibilityItems():void {
        super.setChangedVisibilityItems();
        addItemsToChangedVisibilityList(this.rallyInfo);
    }

    override protected function getSlots():Vector.<IRallySimpleSlotRenderer> {
        if (this._slots == null) {
            this._slots = this.createSlots();
        }
        return this._slots;
    }

    override protected function configUI():void {
        super.configUI();
        rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS, model);
        vehiclesInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_VEHICLES;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (model != null && model.isAvailable()) {
                rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS, model);
            }
        }
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        var _loc2_:int = 0;
        var _loc3_:String = null;
        for each(_loc1_ in this._slots) {
            _loc1_.dispose();
            _loc1_ = null;
        }
        _loc2_ = 0;
        while (this.hasOwnProperty(_loc3_ = "slot" + _loc2_++)) {
            this[_loc3_] = null;
        }
        this.rallyInfo.dispose();
        this.rallyInfo = null;
        super.onDispose();
    }

    override protected function onControlRollOver(param1:Object):void {
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function update(param1:Object):void {
        var _loc2_:IRallyVO = param1 as IRallyVO;
        if (param1 != null) {
            App.utils.asserter.assertNotNull(_loc2_, Errors.INVALID_TYPE + "IRallyVO");
        }
        this.setData(_loc2_);
    }

    public function updateRallyIcon(param1:String):void {
        this.rallyInfo.updateIcon(param1);
    }

    private function createSlots():Vector.<IRallySimpleSlotRenderer> {
        var _loc2_:RallySimpleSlotRenderer = null;
        var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0, this.slot1, this.slot2, this.slot3, this.slot4, this.slot5, this.slot6];
        var _loc3_:ISlotRendererHelper = new StaticRallyUnitSlotHelper();
        var _loc4_:int = 0;
        for each(_loc2_ in _loc1_) {
            _loc2_.helper = _loc3_;
            _loc2_.index = _loc4_++;
        }
        return _loc1_;
    }
}
}
