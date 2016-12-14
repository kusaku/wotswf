package net.wg.gui.lobby.header.itemSelectorPopover {
import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.data.Aliases;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.events.ItemSelectorRendererEvent;
import net.wg.gui.components.miniclient.BattleTypeMiniClientComponent;
import net.wg.gui.components.popovers.PopOverConst;
import net.wg.gui.lobby.header.events.BattleTypeSelectorEvent;
import net.wg.infrastructure.base.meta.IBattleTypeSelectPopoverMeta;
import net.wg.infrastructure.base.meta.impl.BattleTypeSelectPopoverMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IListItemRenderer;

public class ItemSelectorPopover extends BattleTypeSelectPopoverMeta implements IBattleTypeSelectPopoverMeta {

    private static const LIPS_PADDING:int = 10;

    private static const LIST_TOP_PADDING:int = -8;

    private static const LIST_LEFT_PADDING:int = -6;

    private static const LIST_RIGHT_PADDING:int = -6;

    private static const LINK_GAP:int = 2;

    public var list:ItemSelectorList = null;

    public var topLip:MovieClip = null;

    public var bottomLip:MovieClip = null;

    private var _demonstrationItem:BattleTypeSelectPopoverDemonstrator = null;

    private var _items:DataProvider = null;

    private var _isShowDemonstrator:Boolean = false;

    private var _hitSprite:Sprite;

    private var _miniClientComponent:BattleTypeMiniClientComponent = null;

    public function ItemSelectorPopover() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.topLip.mouseChildren = this.bottomLip.mouseChildren = false;
        this.topLip.mouseEnabled = this.bottomLip.mouseEnabled = false;
        this.list.y = LIST_TOP_PADDING + LIPS_PADDING;
        this.list.x = LIST_LEFT_PADDING;
        this._hitSprite = new Sprite();
        addChildAt(this._hitSprite, getChildIndex(this.list));
        hitArea = this._hitSprite;
        if (!hasEventListener(ListEvent.INDEX_CHANGE)) {
            addEventListener(ItemSelectorRendererEvent.RENDERER_CLICK, this.onRendererClickHandler, false, 0, true);
            addEventListener(ItemSelectorRendererEvent.RENDERER_OVER, this.onRendererOverHandler, false, 0, true);
        }
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
        super.initLayout();
    }

    override protected function draw():void {
        var _loc1_:Graphics = null;
        if (_baseDisposed) {
            return;
        }
        if (isInvalid(InvalidationType.DATA) && this._items != null) {
            if (this._demonstrationItem != null) {
                this._demonstrationItem.visible = this._isShowDemonstrator;
            }
            this.list.y = !!this._isShowDemonstrator ? Number(this._demonstrationItem.y + this._demonstrationItem.height + LIST_TOP_PADDING ^ 0) : Number(LIPS_PADDING + LIST_TOP_PADDING);
            this.list.rowCount = this._items.length;
            this.list.dataProvider = this._items;
            this.updateSelectedItem();
            this.list.validateNow();
            this.topLip.y = !!this._isShowDemonstrator ? Number(this._demonstrationItem.y - this.topLip.height) : Number(this.list.y - this.topLip.height - LIST_TOP_PADDING);
            this.bottomLip.y = this.list.y + this.list.height + this.bottomLip.height - LIST_TOP_PADDING ^ 0;
            _loc1_ = this._hitSprite.graphics;
            _loc1_.clear();
            _loc1_.beginFill(0, 0);
            _loc1_.drawRect(0, 0, this.list.width + LIST_RIGHT_PADDING + LIST_LEFT_PADDING, this.list.y + this.list.height + this.list._gap + LIST_TOP_PADDING + LIPS_PADDING);
            _loc1_.endFill();
            setSize(this._hitSprite.width, this._hitSprite.height);
        }
        if (this._miniClientComponent != null) {
            this.updateSizeMiniClientInfo();
        }
        super.draw();
    }

    override protected function onDispose():void {
        removeEventListener(ItemSelectorRendererEvent.RENDERER_CLICK, this.onRendererClickHandler);
        removeEventListener(ItemSelectorRendererEvent.RENDERER_OVER, this.onRendererOverHandler);
        if (this._demonstrationItem != null) {
            this._demonstrationItem.removeEventListener(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT, this.onDemonstrationItemBattleTypeItemEventHandler);
            this._demonstrationItem.dispose();
            this._demonstrationItem = null;
        }
        this.list.dispose();
        this.list = null;
        this.topLip = null;
        this.bottomLip = null;
        hitArea = null;
        this._hitSprite = null;
        this._items = null;
        this._miniClientComponent = null;
        super.onDispose();
    }

    public function as_showMiniClientInfo(param1:String, param2:String):void {
        this._miniClientComponent = App.utils.classFactory.getComponent(Linkages.BATTLE_TYPES_MINI_CLIENT_COMPONENT, BattleTypeMiniClientComponent);
        this._miniClientComponent.gap = LINK_GAP;
        this._miniClientComponent.autoAlignVerticalCenter = true;
        this._miniClientComponent.autoAlignHorizontalCenter = true;
        this._miniClientComponent.update(param1, param2);
        addChild(this._miniClientComponent);
        registerFlashComponentS(this._miniClientComponent, Aliases.MINI_CLIENT_LINKED);
        if (this.list.rowCount > 0) {
            this.updateSizeMiniClientInfo();
        }
    }

    override protected function update(param1:DataProvider, param2:Boolean, param3:Boolean):void {
        this._items = param1;
        this._isShowDemonstrator = param2;
        if (this._isShowDemonstrator) {
            this.createDemonstrator();
            this._demonstrationItem.enabled = param3;
        }
        invalidateData();
    }

    private function createDemonstrator():void {
        if (this._demonstrationItem == null) {
            this._demonstrationItem = App.utils.classFactory.getComponent(Aliases.ITEM_SELECTOR_DEMONSTRATOR, BattleTypeSelectPopoverDemonstrator);
            addChild(this._demonstrationItem);
            this._demonstrationItem.addEventListener(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT, this.onDemonstrationItemBattleTypeItemEventHandler);
            this._demonstrationItem.y = LIPS_PADDING;
        }
    }

    private function updateSizeMiniClientInfo():void {
        var _loc5_:IListItemRenderer = null;
        var _loc1_:int = 0;
        var _loc2_:Boolean = false;
        var _loc3_:int = this.list.rowCount;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = this.list.getRendererAt(_loc4_);
            if (!_loc5_.enabled) {
                _loc1_ = _loc1_ + this.list.rowHeight;
                if (!_loc2_) {
                    this._miniClientComponent.y = _loc5_.y + (this.list._gap >> 1) + LIST_TOP_PADDING + LIPS_PADDING;
                    _loc2_ = true;
                }
            }
            _loc4_++;
        }
        this._miniClientComponent.height = _loc1_;
        this._miniClientComponent.width = width;
    }

    private function updateSelectedItem():void {
        if (this.list.selectedIndex == -1) {
            this.list.selectedIndex = this.list.getFirstSelectablePosition(0, true);
        }
        else if (this.list.selectedIndex < this.list.getFirstSelectablePosition(this.list.dataProvider.length - 1, false)) {
            this.list.selectedIndex = this.list.getFirstSelectablePosition(this.list.selectedIndex, true);
        }
        else {
            this.list.selectedIndex = this.list.getFirstSelectablePosition(0, true);
        }
    }

    private function onRendererOverHandler(param1:ItemSelectorRendererEvent):void {
        var _loc2_:String = getTooltipData(param1.itemData);
        if (_loc2_ && _loc2_ != Values.EMPTY_STR) {
            App.toolTipMgr.showComplex(_loc2_);
        }
    }

    private function onRendererClickHandler(param1:ItemSelectorRendererEvent):void {
        param1.stopImmediatePropagation();
        selectFightS(ItemSelectorRendererVO(param1.target.data).data);
        App.popoverMgr.hide();
    }

    private function onDemonstrationItemBattleTypeItemEventHandler(param1:BattleTypeSelectorEvent):void {
        demoClickS();
    }
}
}
