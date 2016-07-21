package net.wg.gui.lobby.clans.profile.views {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import net.wg.gui.fortBase.IFortBuilding;
import net.wg.gui.fortBase.IFortBuildingsContainer;
import net.wg.gui.fortBase.IFortLandscapeCmp;
import net.wg.gui.fortBase.events.FortInitEvent;
import net.wg.gui.lobby.clans.invites.components.TextValueBlock;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationsSchemaViewVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationsTextsVO;
import net.wg.gui.lobby.clans.profile.cmp.BuildingShape;

import org.idmedia.as3commons.util.StringUtils;

public class ClanProfileFortificationSchemaView extends ClanProfileFortificationAbstractTabView {

    private static const SCREEN_WIDTH:int = 1006;

    private static const SCREEN_HEIGHT:int = 503;

    private static const BOTTOM_TEXTS_GAP:int = 40;

    private static const BITMAP_H_SPACE:int = -300;

    private static const BITMAP_V_SPACE:int = -270;

    private static const TAB_H_OFFSET:int = -35;

    public var schema:IFortLandscapeCmp = null;

    public var totalBuildingsBlock:TextValueBlock = null;

    public var totalDirectionsBlock:TextValueBlock = null;

    public var defenceHourBlock:TextValueBlock = null;

    public var serverBlock:TextValueBlock = null;

    public var vacationBlock:TextValueBlock = null;

    public var dayOffBlock:TextValueBlock = null;

    private var _schemaBmp:Bitmap = null;

    private var _buildingShapes:Vector.<BuildingShape> = null;

    private var _buildingsLoaded:int = 0;

    private var _totalBuildings:int = 0;

    private var _isBgLoaded:Boolean = false;

    private var _isAlreadyLoaded:Boolean = false;

    private var _bottomTextBlocks:Vector.<TextValueBlock>;

    private var _fortBuildingsContainer:IFortBuildingsContainer = null;

    public function ClanProfileFortificationSchemaView() {
        super();
    }

    private static function setBlockValue(param1:TextValueBlock, param2:String):void {
        if (param1 != null) {
            param1.setValue(param2);
            param1.visible = StringUtils.isNotEmpty(param2);
        }
    }

    override protected function configUI():void {
        var _loc2_:IFortBuilding = null;
        super.configUI();
        this.schema.visible = false;
        this.totalBuildingsBlock.setLabel(CLANS.SECTION_FORT_VIEW_SCHEMA_LABELS_TOTALBUILDINGS);
        this.totalDirectionsBlock.setLabel(CLANS.SECTION_FORT_VIEW_SCHEMA_LABELS_TOTALDIRECTIONS);
        this.defenceHourBlock.setLabel(CLANS.SECTION_FORT_VIEW_SCHEMA_LABELS_DEFENCEHOUR);
        this.serverBlock.setLabel(CLANS.SECTION_FORT_VIEW_SCHEMA_LABELS_SERVER);
        this.vacationBlock.setLabel(CLANS.SECTION_FORT_VIEW_SCHEMA_LABELS_VACATION);
        this.dayOffBlock.setLabel(CLANS.SECTION_FORT_VIEW_SCHEMA_LABELS_DAYOFF);
        this._bottomTextBlocks = new <TextValueBlock>[this.defenceHourBlock, this.serverBlock, this.vacationBlock, this.dayOffBlock];
        this.schema.addEventListener(FortInitEvent.LANDSCAPE_LOADING_COMPLETE, this.onSchemaLandscapeLoadingCompleteHandler);
        this._fortBuildingsContainer = this.schema.buildingContainer;
        var _loc1_:Vector.<IFortBuilding> = this._fortBuildingsContainer.buildings;
        for each(_loc2_ in _loc1_) {
            _loc2_.addEventListener(Event.COMPLETE, this.onBuildingCompleteHandler);
            _loc2_.setIsInOverviewMode(true);
        }
    }

    override protected function applyData():void {
        var _loc1_:ClanProfileFortificationsTextsVO = null;
        var _loc2_:ClanProfileFortificationsSchemaViewVO = null;
        var _loc3_:Vector.<IFortBuilding> = null;
        var _loc4_:IFortBuilding = null;
        if (!this._isAlreadyLoaded && _model != null) {
            _loc1_ = _model.fortSortiesSchema.texts;
            this.totalBuildingsBlock.setValue(_loc1_.totalBuildingsCount);
            this.totalDirectionsBlock.setValue(_loc1_.totalDirectionsCount);
            setBlockValue(this.defenceHourBlock, _loc1_.defenceHour);
            setBlockValue(this.serverBlock, _loc1_.server);
            setBlockValue(this.vacationBlock, _loc1_.vacation);
            setBlockValue(this.dayOffBlock, _loc1_.dayOff);
            _loc2_ = _model.fortSortiesSchema;
            if (_loc2_.buildingData.length > 0) {
                this.schema.setInitialData(_loc2_);
            }
            this._totalBuildings = 0;
            _loc3_ = this._fortBuildingsContainer.buildings;
            for each(_loc4_ in _loc3_) {
                if (_loc4_.isAvailable()) {
                    this._totalBuildings++;
                }
            }
            this.layoutTextBlocks();
        }
    }

    override protected function onDispose():void {
        this.cleanUpSchema();
        this.cleanSchemaBitmap();
        this.totalBuildingsBlock.dispose();
        this.totalDirectionsBlock.dispose();
        this.defenceHourBlock.dispose();
        this.serverBlock.dispose();
        this.vacationBlock.dispose();
        this.dayOffBlock.dispose();
        this.totalBuildingsBlock = null;
        this.totalDirectionsBlock = null;
        this.defenceHourBlock = null;
        this.serverBlock = null;
        this.vacationBlock = null;
        this.dayOffBlock = null;
        this._fortBuildingsContainer = null;
        this._bottomTextBlocks.splice(0, this._bottomTextBlocks.length);
        this._bottomTextBlocks = null;
        super.onDispose();
    }

    override protected function onBeforeDispose():void {
        super.onBeforeDispose();
        if (this.schema != null && this.schema.hasEventListener(FortInitEvent.LANDSCAPE_LOADING_COMPLETE)) {
            this.schema.removeEventListener(FortInitEvent.LANDSCAPE_LOADING_COMPLETE, this.onSchemaLandscapeLoadingCompleteHandler);
        }
    }

    private function cleanSchemaBitmap():void {
        var _loc1_:BuildingShape = null;
        if (this._schemaBmp != null) {
            removeChild(this._schemaBmp);
            this._schemaBmp = null;
        }
        if (this._buildingShapes != null) {
            for each(_loc1_ in this._buildingShapes) {
                _loc1_.dispose();
                removeChild(_loc1_);
            }
            this._buildingShapes.splice(0, this._buildingShapes.length);
            this._buildingShapes = null;
        }
    }

    private function layoutTextBlocks():void {
        var _loc2_:TextValueBlock = null;
        var _loc3_:* = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc1_:int = 0;
        for each(_loc2_ in this._bottomTextBlocks) {
            if (_loc2_.visible) {
                _loc1_ = _loc1_ + _loc2_.getWidth();
            }
        }
        _loc3_ = SCREEN_WIDTH - _loc1_ - BOTTOM_TEXTS_GAP * (this._bottomTextBlocks.length - 1) >> 1;
        _loc4_ = 0;
        _loc5_ = _loc3_;
        for each(_loc2_ in this._bottomTextBlocks) {
            if (_loc2_.visible) {
                _loc5_ = _loc5_ + _loc2_.getLabelWidth();
                _loc2_.x = _loc5_;
                _loc5_ = _loc5_ + (_loc2_.getValueWidth() + BOTTOM_TEXTS_GAP);
                _loc4_++;
            }
        }
    }

    private function checkIfLoadingComplete():void {
        if (!this._isAlreadyLoaded && this._buildingsLoaded != 0 && this._totalBuildings == this._buildingsLoaded && this._isBgLoaded) {
            this.makeSchemaBitmap();
            this._isAlreadyLoaded = true;
        }
    }

    private function makeSchemaBitmap():void {
        var _loc1_:DisplayObject = null;
        var _loc2_:BitmapData = null;
        var _loc3_:Vector.<IFortBuilding> = null;
        var _loc4_:IFortBuilding = null;
        var _loc5_:DisplayObject = null;
        var _loc6_:BuildingShape = null;
        this.cleanSchemaBitmap();
        if (this.schema != null) {
            _loc1_ = DisplayObject(this.schema);
            _loc2_ = new BitmapData(SCREEN_WIDTH, SCREEN_HEIGHT);
            _loc2_.draw(_loc1_, new Matrix(1, 0, 0, 1, BITMAP_H_SPACE, BITMAP_V_SPACE), null, null, new Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT));
            this._schemaBmp = new Bitmap(_loc2_);
            this._schemaBmp.x = 0;
            this._schemaBmp.y = TAB_H_OFFSET;
            addChildAt(this._schemaBmp, getChildIndex(_loc1_));
            this._buildingShapes = new Vector.<BuildingShape>();
            _loc3_ = this._fortBuildingsContainer.buildings;
            for each(_loc4_ in _loc3_) {
                if (_loc4_.isAvailable() && _loc4_.buildingLevel > 0) {
                    _loc5_ = _loc4_.getHitArea();
                    _loc6_ = new BuildingShape(new Rectangle(_loc4_.x + _loc5_.x + BITMAP_H_SPACE, _loc4_.y + _loc5_.y + BITMAP_V_SPACE + TAB_H_OFFSET, _loc5_.width, _loc5_.height), _loc4_.uid, _loc4_.buildingLevel);
                    this._buildingShapes.push(_loc6_);
                    addChild(_loc6_);
                }
            }
            removeChild(_loc1_);
            this.cleanUpSchema();
        }
    }

    private function cleanUpSchema():void {
        var _loc1_:Vector.<IFortBuilding> = null;
        var _loc2_:IFortBuilding = null;
        if (this.schema != null) {
            _loc1_ = this._fortBuildingsContainer.buildings;
            for each(_loc2_ in _loc1_) {
                if (_loc2_.hasEventListener(Event.COMPLETE)) {
                    _loc2_.removeEventListener(Event.COMPLETE, this.onBuildingCompleteHandler);
                }
            }
            if (this.schema.hasEventListener(FortInitEvent.LANDSCAPE_LOADING_COMPLETE)) {
                this.schema.removeEventListener(FortInitEvent.LANDSCAPE_LOADING_COMPLETE, this.onSchemaLandscapeLoadingCompleteHandler);
            }
            this.schema.dispose();
            this.schema = null;
        }
    }

    private function onSchemaLandscapeLoadingCompleteHandler(param1:FortInitEvent):void {
        this._isBgLoaded = true;
        this.checkIfLoadingComplete();
    }

    private function onBuildingCompleteHandler(param1:Event):void {
        var _loc2_:IFortBuilding = IFortBuilding(param1.currentTarget);
        _loc2_.removeEventListener(Event.COMPLETE, this.onBuildingCompleteHandler);
        this._buildingsLoaded++;
        this.checkIfLoadingComplete();
    }
}
}
