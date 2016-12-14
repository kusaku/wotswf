package net.wg.gui.lobby.quests.components {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.interfaces.IContentSize;
import net.wg.gui.lobby.quests.data.SeasonVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.IClassFactory;

import scaleform.clik.constants.InvalidationType;

public class SeasonViewRenderer extends UIComponentEx implements IContentSize {

    private static const ITEMS_IN_ROW:uint = 3;

    private static const ITEMS_HORIZONTAL_GAP:uint = 20;

    private static const ITEMS_VERTICAL_GAP:uint = 20;

    public var titleTF:TextField;

    public var container:Sprite;

    private var _model:SeasonVO;

    public function SeasonViewRenderer() {
        super();
    }

    override protected function onDispose():void {
        this.clearItems();
        this._model = null;
        this.titleTF = null;
        this.container = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._model && isInvalid(InvalidationType.DATA)) {
            this.redrawItems();
            this.titleTF.htmlText = this._model.title;
        }
    }

    private function redrawItems():void {
        var _loc1_:QuestTileRenderer = null;
        this.clearItems();
        if (this._model == null || !this._model.hasTiles()) {
            return;
        }
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:IClassFactory = App.utils.classFactory;
        var _loc5_:Array = this._model.tiles;
        var _loc6_:int = _loc5_.length;
        var _loc7_:int = 0;
        while (_loc7_ < _loc6_) {
            _loc1_ = _loc4_.getComponent(Linkages.QUEST_TILE_RENDERER, QuestTileRenderer);
            _loc1_.model = _loc5_[_loc7_];
            _loc2_ = _loc7_ / ITEMS_IN_ROW;
            _loc3_ = _loc7_ % ITEMS_IN_ROW;
            _loc1_.x = _loc3_ * (QuestTileRenderer.CONTENT_WIDTH + ITEMS_HORIZONTAL_GAP) | 0;
            _loc1_.y = _loc2_ * (QuestTileRenderer.CONTENT_HEIGHT + ITEMS_VERTICAL_GAP) | 0;
            this.container.addChild(_loc1_);
            _loc1_.validateNow();
            _loc7_++;
        }
    }

    private function clearItems():void {
        var _loc1_:QuestTileRenderer = null;
        while (this.container.numChildren) {
            _loc1_ = QuestTileRenderer(this.container.getChildAt(0));
            this.container.removeChild(_loc1_);
            _loc1_.dispose();
        }
    }

    public function get model():SeasonVO {
        return this._model;
    }

    public function set model(param1:SeasonVO):void {
        this._model = param1;
        invalidateData();
    }

    public function get contentWidth():Number {
        return width;
    }

    public function get contentHeight():Number {
        var _loc1_:int = 0;
        if (this._model != null || this._model.hasTiles()) {
            _loc1_ = this._model.tiles.length;
        }
        var _loc2_:int = Math.ceil(_loc1_ / ITEMS_IN_ROW);
        var _loc3_:Number = this.container.y + _loc2_ * (QuestTileRenderer.CONTENT_HEIGHT + ITEMS_VERTICAL_GAP);
        return _loc3_;
    }
}
}
