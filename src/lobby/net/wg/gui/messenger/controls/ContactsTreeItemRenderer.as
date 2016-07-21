package net.wg.gui.messenger.controls {
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.constants.Cursors;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.messenger.data.ContactItemVO;
import net.wg.gui.messenger.data.ContactsListTreeItemInfo;
import net.wg.gui.messenger.data.ITreeItemInfo;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.InputEvent;

public class ContactsTreeItemRenderer extends ContactItemRenderer {

    private static const ITEM_INSIDE_GROUP_PADDING:int = 10;

    private var myData:ITreeItemInfo;

    private var dashedArea:EmptyHighlightArea;

    private var contactItem:ContactItem;

    private var mainGroupItem:MainGroupItem;

    private var contactGroupItem:ContactGroupItem;

    private var currentContentItem:UIComponent;

    private var _isNewDataIsEqualOldData:Boolean = true;

    public function ContactsTreeItemRenderer() {
        super();
        _toggle = false;
    }

    override public function getCurrentContentItem():UIComponent {
        return this.currentContentItem;
    }

    override public function getData():Object {
        return this.myData;
    }

    override public function setData(param1:Object):void {
        this._isNewDataIsEqualOldData = false;
        if (param1 && this.myData) {
            if ((this.myData as ContactsListTreeItemInfo).isEquals(param1 as ContactsListTreeItemInfo)) {
                this._isNewDataIsEqualOldData = true;
                return;
            }
        }
        this.myData = ITreeItemInfo(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        constraintsDisabled = true;
        constraints = null;
    }

    override protected function draw():void {
        var _loc2_:Boolean = false;
        var _loc3_:UIComponent = null;
        var _loc4_:IUpdatable = null;
        var _loc5_:EmptyRowVO = null;
        var _loc6_:Number = NaN;
        super.draw();
        var _loc1_:Boolean = isInvalid(InvalidationType.DATA) && !this._isNewDataIsEqualOldData;
        if (_loc1_) {
            if (this.myData) {
                visible = true;
                _loc2_ = true;
                if (this.myData.isBrunch) {
                    if (this.myData.parent == null) {
                        if (this.mainGroupItem == null) {
                            this.mainGroupItem = App.utils.classFactory.getComponent("MainGroupItemUI", MainGroupItem);
                        }
                        _loc3_ = this.mainGroupItem;
                        _loc2_ = false;
                    }
                    else {
                        if (this.contactGroupItem == null) {
                            this.contactGroupItem = App.utils.classFactory.getComponent("ContactGroupItemUI", ContactGroupItem);
                        }
                        _loc3_ = this.contactGroupItem;
                    }
                }
                else if (this.myData.gui["id"] == null) {
                    if (this.dashedArea == null) {
                        this.dashedArea = App.utils.classFactory.getComponent("EmptyHighlightAreaUI", EmptyHighlightArea);
                        this.dashedArea.setSize(_width, _height);
                    }
                    _loc5_ = new EmptyRowVO(this.myData.data);
                    _loc6_ = !!_loc5_.isVisible ? Number(1) : Number(0);
                    this.dashedArea.dashedAreaAlpha = _loc6_;
                    this.dashedArea.defaultTextAlpha = _loc6_;
                    _loc3_ = this.dashedArea;
                    _loc2_ = _loc5_.isActive;
                }
                else {
                    if (this.contactItem == null) {
                        this.contactItem = App.utils.classFactory.getComponent("ContactItemUI", ContactItem);
                    }
                    if (this.myData.parent.parent == null) {
                        this.contactItem.x = 0;
                        this.contactItem.width = _width;
                    }
                    else {
                        this.contactItem.x = ITEM_INSIDE_GROUP_PADDING;
                        this.contactItem.width = _width - ITEM_INSIDE_GROUP_PADDING;
                    }
                    _loc3_ = this.contactItem;
                }
                if (_loc3_ != this.currentContentItem) {
                    if (this.currentContentItem) {
                        removeChild(this.currentContentItem);
                    }
                    addChild(_loc3_);
                }
                this.currentContentItem = _loc3_;
                _loc4_ = this.currentContentItem as IUpdatable;
                if (_loc4_) {
                    _loc4_.update(this.myData.data);
                    this.currentContentItem.validateNow();
                }
                this.enabled = _loc2_;
                if (this.isItemOver() && !this._isNewDataIsEqualOldData) {
                    this.updateTooltip();
                }
            }
            else {
                visible = false;
            }
            this._isNewDataIsEqualOldData = true;
        }
        if (_loc1_ || isInvalid(DRAGGING_ITEM_INV)) {
            alpha = !isNaN(draggedItemId) && this.currentContentItem != null && this.currentContentItem == this.contactItem && ContactItemVO(this.contactItem.data).dbID == draggedItemId ? Number(0.3) : Number(1);
        }
    }

    override protected function onDispose():void {
        if (this.dashedArea) {
            this.dashedArea.dispose();
            this.dashedArea = null;
        }
        if (this.contactItem) {
            this.contactItem.dispose();
        }
        if (this.mainGroupItem) {
            this.mainGroupItem.dispose();
        }
        if (this.contactGroupItem) {
            this.contactGroupItem.dispose();
        }
        this.contactItem = null;
        this.mainGroupItem = null;
        this.contactGroupItem = null;
        this.currentContentItem = null;
        background = null;
        super.onDispose();
        this.myData = null;
    }

    protected function showTooltip():void {
        var _loc1_:ContactItemVO = null;
        if (this.currentContentItem == this.contactItem && this.contactItem) {
            _loc1_ = ContactItemVO(this.contactItem.data);
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CONTACT, null, _loc1_.dbID, null);
        }
        else if (this.currentContentItem == this.contactGroupItem) {
            App.toolTipMgr.show(this.contactGroupItem.label);
        }
    }

    protected function hideTooltip():void {
        App.toolTipMgr.hide();
    }

    private function updateTooltip():void {
        this.hideTooltip();
        if (this.myData.gui["id"] != null && !this.myData.isBrunch) {
            this.showTooltip();
        }
    }

    private function isItemOver():Boolean {
        var _loc1_:Point = new Point(mouseX, mouseY);
        _loc1_ = this.localToGlobal(_loc1_);
        return this.hitTestPoint(_loc1_.x, _loc1_.y, true);
    }

    override public function set enabled(param1:Boolean):void {
        if (super.enabled == param1) {
            return;
        }
        super.enabled = param1;
    }

    override public function get data():Object {
        return this.myData;
    }

    override public function get getCursorType():String {
        if (this.currentContentItem == this.contactItem) {
            return Cursors.DRAG_OPEN;
        }
        if (this.currentContentItem == this.contactGroupItem) {
            return Cursors.HAND;
        }
        return Cursors.ARROW;
    }

    override public function handleInput(param1:InputEvent):void {
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this.showTooltip();
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this.hideTooltip();
    }
}
}

import net.wg.data.daapi.base.DAAPIDataClass;

class EmptyRowVO extends DAAPIDataClass {

    public var isActive:Boolean;

    public var isVisible:Boolean;

    function EmptyRowVO(param1:Object) {
        super(param1);
    }
}
