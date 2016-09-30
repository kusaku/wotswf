package net.wg.gui.lobby.vehicleInfo {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.components.advanced.TextAreaSimple;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehicleInfo.data.VehCompareButtonDataVO;
import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoDataVO;
import net.wg.infrastructure.base.meta.IVehicleInfoMeta;
import net.wg.infrastructure.base.meta.impl.VehicleInfoMeta;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;

public class VehicleInfo extends VehicleInfoMeta implements IVehicleInfoMeta {

    private static const VEHICLE_INFO_PROPS:String = "VehicleInfoPropsUI";

    private static const VEHICLE_INFO_BASE:String = "VehicleInfoBaseUI";

    private static const VEHICLE_INFO_CREW:String = "VehicleInfoCrewUI";

    private static const INV_COMPARE_DATA:String = "InvCompareData";

    public var vehicleIcon:TankIcon;

    public var moduleName:TextField;

    public var descriptionField:TextAreaSimple;

    public var tabs:ButtonBarEx;

    public var view:ViewStack;

    public var compareBtn:ISoundButtonEx;

    public var closeBtn:ISoundButtonEx;

    private var _compareData:VehCompareButtonDataVO;

    private var _data:VehicleInfoDataVO;

    public function VehicleInfo() {
        super();
        isModal = false;
        canResize = false;
        canMinimize = false;
        isCentered = false;
        showWindowBgForm = false;
    }

    override protected function setCompareButtonData(param1:VehCompareButtonDataVO):void {
        this._compareData = param1;
        invalidate(INV_COMPARE_DATA);
    }

    override protected function configUI():void {
        super.configUI();
        this.view.addEventListener(ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
        this.tabs.dataProvider = new DataProvider([{
            "label": MENU.VEHICLEINFO_TABS_PROPERTIES,
            "linkage": VEHICLE_INFO_PROPS
        }, {
            "label": MENU.VEHICLEINFO_TABS_BASE,
            "linkage": VEHICLE_INFO_BASE
        }, {
            "label": MENU.VEHICLEINFO_TABS_CREW,
            "linkage": VEHICLE_INFO_CREW
        }]);
        this.compareBtn.mouseEnabledOnDisabled = true;
        this.compareBtn.addEventListener(ButtonEvent.CLICK, this.onCompareBtnClickHandler);
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
    }

    override protected function draw():void {
        var _loc1_:String = null;
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._data.vehicleName;
            this.window.title = _loc1_;
            this.moduleName.htmlText = _loc1_;
            this.descriptionField.text = this._data.vehicleDescription;
            this.vehicleIcon.image = this._data.vehicleImage;
            this.vehicleIcon.level = this._data.vehicleLevel;
            this.vehicleIcon.nation = this._data.vehicleNation;
            this.vehicleIcon.isElite = this._data.vehicleElite;
            this.vehicleIcon.tankType = this._data.vehicleType;
            this.tabs.selectedIndex = 0;
        }
        if (this._compareData && isInvalid(INV_COMPARE_DATA)) {
            this.compareBtn.visible = this._compareData.visible;
            if (this.compareBtn.visible) {
                this.compareBtn.enabled = this._compareData.enabled;
                this.compareBtn.label = this._compareData.label;
                this.compareBtn.tooltip = this._compareData.tooltip;
            }
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        getVehicleInfoS();
        var _loc1_:Padding = new Padding(window.formBgPadding.top, window.formBgPadding.right, window.formBgPadding.bottom + 1, window.formBgPadding.left);
        window.contentPadding = _loc1_;
        window.titleUseHtml = true;
    }

    override protected function onDispose():void {
        this.view.removeEventListener(ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
        this.view.dispose();
        this.view = null;
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.compareBtn.removeEventListener(ButtonEvent.CLICK, this.onCompareBtnClickHandler);
        this.compareBtn.dispose();
        this.compareBtn = null;
        this.tabs.dispose();
        this.tabs = null;
        this.vehicleIcon.dispose();
        this.vehicleIcon = null;
        this.descriptionField.dispose();
        this.descriptionField = null;
        this.moduleName = null;
        this._compareData = null;
        this._data = null;
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(InteractiveObject(this.closeBtn));
    }

    override protected function setVehicleInfo(param1:VehicleInfoDataVO):void {
        this._data = param1;
        invalidateData();
    }

    private function onCompareBtnClickHandler(param1:ButtonEvent):void {
        addToCompareS();
    }

    private function onViewNeedUpdateHandler(param1:ViewStackEvent):void {
        var _loc2_:IViewStackContent = param1.view;
        var _loc3_:String = param1.linkage;
        if (VEHICLE_INFO_PROPS == _loc3_) {
            _loc2_.update(this._data.propsData);
        }
        else if (VEHICLE_INFO_CREW == _loc3_) {
            _loc2_.update(this._data.crewData);
        }
        else if (VEHICLE_INFO_BASE == _loc3_) {
            _loc2_.update(this._data.baseData);
        }
        else {
            App.utils.asserter.assert(false, Errors.BAD_LINKAGE + _loc3_);
        }
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        onCancelClickS();
    }
}
}
