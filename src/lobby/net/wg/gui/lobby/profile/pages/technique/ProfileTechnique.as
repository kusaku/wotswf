package net.wg.gui.lobby.profile.pages.technique {
import flash.events.Event;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS;
import net.wg.gui.lobby.profile.ProfileConstants;
import net.wg.gui.lobby.profile.data.SectionLayoutManager;
import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
import net.wg.infrastructure.base.meta.IProfileTechniqueMeta;
import net.wg.infrastructure.base.meta.impl.ProfileTechniqueMeta;

import scaleform.clik.data.DataProvider;

public class ProfileTechnique extends ProfileTechniqueMeta implements IProfileTechniqueMeta {

    private static const CURRENT_DIMENSION_INVALID:String = "cdInv";

    private static const ADDITIONAL_LIST_HEIGHT:int = 3;

    private static const MIN_HEIGHT:int = 525;

    private static const MAX_HEIGHT:int = 740;

    public var listComponent:TechniqueListComponent = null;

    public var stackComponent:TechniqueStackComponent = null;

    public var emptyScreen:ProfileTechniqueEmptyScreen = null;

    protected var techniqueInitVO:TechStatisticsInitVO = null;

    public function ProfileTechnique() {
        super();
        this.listComponent.addEventListener(TechniqueListComponent.DATA_CHANGED, this.onListComponentDataChangedHandler, false, 0, true);
    }

    override public function as_responseDossier(param1:String, param2:Object, param3:String, param4:String):void {
        super.as_responseDossier(param1, param2, param3, param4);
        this.emptyScreen.text = param4;
    }

    override public function as_setInitData(param1:Object):void {
        this.techniqueInitVO = new TechStatisticsInitVO(param1);
        this.applyInitData();
    }

    protected function applyInitData():void {
        this.listComponent.headerDataProvider = new DataProvider(App.utils.data.vectorToArray(this.techniqueInitVO.tableHeader));
        battlesDropdown.dataProvider = new DataProvider(this.techniqueInitVO.dropDownProvider);
    }

    override protected function initialize():void {
        super.initialize();
        layoutManager = new SectionLayoutManager(MIN_HEIGHT, MAX_HEIGHT);
        layoutManager.registerComponents(this.listComponent, this.stackComponent);
    }

    override protected function applyData(param1:Object):void {
        var _loc3_:* = false;
        var _loc5_:TechniqueListVehicleVO = null;
        var _loc6_:Object = null;
        var _loc2_:Array = [];
        _loc3_ = false;
        var _loc4_:Array = param1 as Array;
        if (_loc4_) {
            for each(_loc6_ in _loc4_) {
                _loc5_ = new TechniqueListVehicleVO(_loc6_);
                _loc2_.push(_loc5_);
            }
            _loc3_ = _loc2_.length > 0;
        }
        this.listComponent.enableMarkOfMasteryBtn(battlesType == PROFILE_DROPDOWN_KEYS.ALL);
        this.stackComponent.enableAwardsButton(battlesType != PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_BATTLES && battlesType != PROFILE_DROPDOWN_KEYS.FORTIFICATIONS_SORTIES && battlesType != PROFILE_DROPDOWN_KEYS.CLAN);
        this.listComponent.vehicles = _loc2_;
        this.emptyScreen.visible = !_loc3_;
        this.listComponent.visible = this.stackComponent.visible = _loc3_;
    }

    override protected function applyResizing():void {
        if (layoutManager != null) {
            layoutManager.setDimension(currentDimension.x, currentDimension.y);
        }
        this.x = Math.round(currentDimension.x * 0.5 - centerOffset);
        var _loc1_:Number = Math.min(currentDimension.x, ProfileConstants.MIN_APP_WIDTH);
        this.emptyScreen.x = _loc1_ - this.emptyScreen.width >> 1;
        this.listComponent.setSize(currentDimension.x, currentDimension.y - this.listComponent.y + ADDITIONAL_LIST_HEIGHT);
        this.stackComponent.setViewSize(_loc1_ - this.stackComponent.x, currentDimension.y - this.stackComponent.y);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(CURRENT_DIMENSION_INVALID) && currentDimension) {
            this.applyResizing();
        }
    }

    override protected function onDispose():void {
        if (this.listComponent != null) {
            this.listComponent.removeEventListener(TechniqueListComponent.DATA_CHANGED, this.onListComponentDataChangedHandler);
            this.listComponent.dispose();
            this.listComponent = null;
        }
        if (this.stackComponent != null) {
            this.stackComponent.dispose();
            this.stackComponent = null;
        }
        if (this.emptyScreen != null) {
            if (this.emptyScreen.parent) {
                this.emptyScreen.parent.removeChild(this.emptyScreen);
            }
            this.emptyScreen.dispose();
            this.emptyScreen = null;
        }
        this.techniqueInitVO.dispose();
        this.techniqueInitVO = null;
        super.onDispose();
    }

    public function as_responseVehicleDossier(param1:Object):void {
        if (param1 != null) {
            this.stackComponent.updateTankData(new ProfileVehicleDossierVO(param1));
        }
        else {
            this.stackComponent.updateTankData(new ProfileVehicleDossierVO({}));
        }
    }

    private function onListComponentDataChangedHandler(param1:Event):void {
        var _loc2_:TechniqueListVehicleVO = this.listComponent.getSelectedItem();
        if (_loc2_ != null) {
            this.stackComponent.updateLabel(_loc2_.userName, _loc2_.typeIconPath);
            requestDataS({"vehicleId": _loc2_.id});
        }
        else {
            this.stackComponent.updateLabel(Values.EMPTY_STR, null);
        }
    }
}
}
