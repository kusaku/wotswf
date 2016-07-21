package net.wg.gui.lobby.profile.pages.statistics {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.lobby.components.StatisticsBodyContainer;
import net.wg.gui.lobby.profile.ProfileConstants;
import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
import net.wg.gui.lobby.profile.pages.statistics.header.HeaderContainer;
import net.wg.infrastructure.base.meta.IProfileStatisticsMeta;
import net.wg.infrastructure.base.meta.impl.ProfileStatisticsMeta;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class ProfileStatistics extends ProfileStatisticsMeta implements IProfileStatisticsMeta {

    private static const HEADER_SEPARATOR_BOTTOM_GAP:int = 100;

    private static const BODY_AND_HEADER_SEPARATOR_GAP:int = 20;

    private static const LAYOUT_WIDTH:int = 525;

    private static const LAYOUT_HEIGHT:int = 740;

    public var headerLabel:TextField = null;

    public var lblSeasonDropdown:TextField = null;

    public var seasonDropdown:DropdownMenu = null;

    public var headerContainer:HeaderContainer = null;

    public var bodyContainer:StatisticsBodyContainer = null;

    private var _bodyParams:ProfileStatisticsBodyVO = null;

    public function ProfileStatistics() {
        super();
    }

    override public function as_setInitData(param1:Object):void {
        var _loc2_:ProfileBattleTypeInitVO = new ProfileBattleTypeInitVO(param1);
        battlesDropdown.dataProvider = new DataProvider(_loc2_.dropDownProvider);
        this.seasonDropdown.enabled = _loc2_.seasonEnabled;
        if (_loc2_.seasonItems.length > 0) {
            this.seasonDropdown.dataProvider = new DataProvider(_loc2_.seasonItems);
            this.seasonDropdown.selectedIndex = _loc2_.seasonIndex;
        }
        this.seasonDropdown.validateNow();
    }

    override protected function initialize():void {
        super.initialize();
        layoutManager = new StatisticsLayoutManager(LAYOUT_WIDTH, LAYOUT_HEIGHT);
        layoutManager.registerComponents(this.headerContainer);
    }

    override protected function applyResizing():void {
        super.applyResizing();
        var _loc1_:MovieClip = this.headerContainer.image.separator;
        this.bodyContainer.y = this.headerContainer.y + _loc1_.y + _loc1_.height - HEADER_SEPARATOR_BOTTOM_GAP + BODY_AND_HEADER_SEPARATOR_GAP;
        var _loc2_:* = Math.min(ProfileConstants.MIN_APP_WIDTH, currentDimension.x) >> 0;
        this.bodyContainer.setAvailableSize(_loc2_, currentDimension.y);
        this.headerLabel.width = _loc2_;
    }

    override protected function applyData(param1:Object):void {
        this.clearData();
        this._bodyParams = new ProfileStatisticsBodyVO(param1.bodyParams);
        this.headerLabel.text = param1.headerText;
        this.lblSeasonDropdown.htmlText = param1.dropdownSeasonLabel;
        this.lblSeasonDropdown.visible = this.seasonDropdown.visible = param1.showSeasonDropdown;
        if (this.seasonDropdown.visible) {
            this.seasonDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onHeaderDropdownIndexChangeHandler);
        }
        else {
            this.seasonDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onHeaderDropdownIndexChangeHandler);
        }
        this.headerContainer.battlesType(battlesType, frameLabel);
        this.headerContainer.setDossierData(param1.headerParams);
        this.bodyContainer.setDossierData(this._bodyParams);
    }

    override protected function onDispose():void {
        this.headerLabel = null;
        this.lblSeasonDropdown = null;
        this.seasonDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onHeaderDropdownIndexChangeHandler);
        this.seasonDropdown.dispose();
        this.seasonDropdown = null;
        this.headerContainer.dispose();
        this.headerContainer = null;
        this.bodyContainer.dispose();
        this.bodyContainer = null;
        this.clearData();
        super.onDispose();
    }

    private function clearData():void {
        if (this._bodyParams) {
            this._bodyParams.dispose();
            this._bodyParams = null;
        }
    }

    private function onHeaderDropdownIndexChangeHandler(param1:ListEvent):void {
        setSeasonS(param1.itemData.key);
    }
}
}
