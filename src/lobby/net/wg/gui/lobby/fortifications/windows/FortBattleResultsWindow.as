package net.wg.gui.lobby.fortifications.windows {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.components.controls.interfaces.ISortableTable;
import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
import net.wg.gui.lobby.fortifications.data.battleResults.BattleResultsVO;
import net.wg.gui.lobby.fortifications.events.FortBattleResultsEvent;
import net.wg.infrastructure.base.meta.IFortBattleResultsWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortBattleResultsWindowMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class FortBattleResultsWindow extends FortBattleResultsWindowMeta implements IFortBattleResultsWindowMeta {

    private static const DEFAULT_CLAN_EMBLEM_VALUE:String = " ";

    private static const RES_ICON_PADDING:int = 4;

    public var bgImage:MovieClip = null;

    public var resultTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var defResReceivedTF:TextField = null;

    public var byClanTF:TextField = null;

    public var byPlayerTF:TextField = null;

    public var clanResTF:TextField = null;

    public var playerResTF:TextField = null;

    public var clanResIcon:MovieClip = null;

    public var playerResIcon:MovieClip = null;

    public var journalTF:TextField = null;

    public var table:ISortableTable = null;

    public var medalsListLeft:BattleResultsMedalsList = null;

    public var medalsListRight:BattleResultsMedalsList = null;

    private var _data:BattleResultsVO = null;

    private var _defaultTopTextY:int = 0;

    private var _centeredTopTextY:int = 0;

    private var _elementsForReposition:Vector.<DisplayObject>;

    public function FortBattleResultsWindow() {
        super();
        isModal = false;
        isCentered = true;
        this._elementsForReposition = new <DisplayObject>[this.defResReceivedTF, this.byClanTF, this.clanResTF, this.clanResIcon];
        this._defaultTopTextY = this.defResReceivedTF.y;
        var _loc1_:int = this.playerResTF.y + this.playerResTF.height - this._defaultTopTextY;
        var _loc2_:int = this.clanResTF.y + this.clanResTF.height - this._defaultTopTextY;
        this._centeredTopTextY = this._defaultTopTextY + (_loc1_ - _loc2_ >> 1);
    }

    override protected function setData(param1:BattleResultsVO):void {
        this._data = param1;
        invalidateData();
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            window.title = this._data.windowTitle;
            this.setBGImage();
            this.setTexts();
            this.setTableData();
            this.setMedalListsData();
            this.clanResIcon.x = this.clanResTF.x + (this.clanResTF.width + this.clanResTF.textWidth >> 1) + RES_ICON_PADDING;
            _loc1_ = 0;
            _loc2_ = this._elementsForReposition.length;
            if (this._data.showByPlayerInfo) {
                _loc1_ = this.defResReceivedTF.y - this._defaultTopTextY;
                this.playerResIcon.x = this.playerResTF.x + (this.playerResTF.width + this.playerResTF.textWidth >> 1) + RES_ICON_PADDING;
            }
            else {
                _loc1_ = this.defResReceivedTF.y - this._centeredTopTextY;
            }
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this._elementsForReposition[_loc3_].y = this._elementsForReposition[_loc3_].y - _loc1_;
                _loc3_++;
            }
            this.byPlayerTF.visible = this._data.showByPlayerInfo;
            this.playerResTF.visible = this._data.showByPlayerInfo;
            this.playerResIcon.visible = this._data.showByPlayerInfo;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.table.addEventListener(FortBattleResultsEvent.MORE_BTN_CLICK, this.onTableMoreBtnClickHandler);
    }

    override protected function onDispose():void {
        this.table.removeEventListener(FortBattleResultsEvent.MORE_BTN_CLICK, this.onTableMoreBtnClickHandler);
        this.table.dispose();
        this.table = null;
        this.medalsListLeft.dispose();
        this.medalsListLeft = null;
        this.medalsListRight.dispose();
        this.medalsListRight = null;
        this._elementsForReposition.splice(0, this._elementsForReposition.length);
        this._elementsForReposition = null;
        this.clanResIcon = null;
        this.playerResIcon = null;
        this.bgImage = null;
        this.resultTF = null;
        this.descriptionTF = null;
        this.defResReceivedTF = null;
        this.byClanTF = null;
        this.byPlayerTF = null;
        this.clanResTF = null;
        this.playerResTF = null;
        this.journalTF = null;
        this._data = null;
        super.onDispose();
    }

    public function as_notAvailableInfo(param1:int):void {
        var _loc2_:DataProvider = DataProvider(this._data.battles);
        _loc2_[param1].infoNotAvailable = true;
        this.table.listDP = _loc2_;
    }

    public function as_setClanEmblem(param1:String):void {
        this.descriptionTF.htmlText = this.makeDescription(param1);
    }

    private function makeDescription(param1:String):String {
        return App.utils.locale.makeString(this._data.descriptionStartText + param1 + this._data.descriptionEndText);
    }

    private function setTexts():void {
        this.resultTF.htmlText = this._data.resultText;
        this.descriptionTF.htmlText = this.makeDescription(DEFAULT_CLAN_EMBLEM_VALUE);
        this.journalTF.htmlText = this._data.journalText;
        this.defResReceivedTF.htmlText = this._data.defResReceivedText;
        this.byClanTF.htmlText = this._data.byClanText;
        this.byPlayerTF.htmlText = this._data.byPlayerText;
        this.clanResTF.htmlText = this._data.clanResText;
        this.playerResTF.htmlText = this._data.playerResText;
        getClanEmblemS();
    }

    private function setBGImage():void {
        this.bgImage.gotoAndStop(this._data.battleResult);
    }

    private function setTableData():void {
        this.table.headerDP = new DataProvider(App.utils.data.vectorToArray(this._data.tableHeader));
        this.table.listDP = this._data.battles;
    }

    private function setMedalListsData():void {
        this.medalsListLeft.dataProvider = this._data.achievementsLeft;
        this.medalsListRight.dataProvider = this._data.achievementsRight;
    }

    private function onTableMoreBtnClickHandler(param1:FortBattleResultsEvent):void {
        getMoreInfoS(param1.rendererID);
    }
}
}
