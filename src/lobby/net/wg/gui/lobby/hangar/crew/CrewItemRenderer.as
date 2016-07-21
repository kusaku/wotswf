package net.wg.gui.lobby.hangar.crew {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.Timer;

import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.controls.TileList;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.CrewEvent;
import net.wg.gui.lobby.hangar.CrewDropDownEvent;
import net.wg.infrastructure.events.TutorialEvent;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.ICommons;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.CoreList;
import scaleform.clik.controls.DropdownMenu;
import scaleform.clik.core.UIComponent;
import scaleform.clik.data.DataProvider;
import scaleform.clik.data.ListData;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ComponentEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.interfaces.IListItemRenderer;
import scaleform.clik.utils.Padding;
import scaleform.gfx.MouseEventEx;

public class CrewItemRenderer extends DropdownMenu implements IListItemRenderer {

    private static const MENU_WIDTH:Number = 368;

    private static const SCROLLBAR_PADDING:Number = 13;

    private static const DROPDOWN:String = "RecruitScrollingList";

    private static const ITEM_RENDERER:String = "RecruitItemRenderer";

    private static const TANKMEN_ICONS_SMALL:String = "../maps/icons/tankmen/icons/small/";

    private static const TANKMEN_RANKS_SMALL:String = "../maps/icons/tankmen/ranks/small/";

    private static const TANKMEN_ROLES_SMALL:String = "../maps/icons/tankmen/roles/small/";

    private static const IMAGE_EXTENSION:String = ".png";

    public var soundType:String = "rendererNormal";

    public var soundId:String = "";

    public var icon:UILoaderAlt = null;

    public var iconRole:TankmenIcons = null;

    public var iconRank:TankmenIcons = null;

    public var bg:Sprite = null;

    public var roles:TileList = null;

    public var skills:TileList = null;

    public var goups_icons:MovieClip = null;

    public var speed_xp_bg:UIComponent = null;

    public var new_skill_anim:MovieClip = null;

    public var levelSpecializationMain:CrewItemLabel = null;

    public var tankmenName:CrewItemLabel = null;

    public var rank:CrewItemLabel = null;

    public var role:CrewItemLabel = null;

    public var vehicleType:TextField = null;

    public var emptySlotBgAnim:MovieClip = null;

    public var lastSkillLevel:TextField = null;

    protected var _index:uint = 0;

    protected var _selectable:Boolean = true;

    public function CrewItemRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        buttonMode = true;
        this.componentInspectorSetting = true;
        dropdown = DROPDOWN;
        itemRenderer = ITEM_RENDERER;
        menuPadding = new Padding(4, 3, 3, 4);
        menuMargin = 0;
        this.new_skill_anim.alpha = 0;
        menuOffset.left = width - 1;
        this.goups_icons.alpha = 1;
        this.inspectableThumbOffset = {
            "top": 0,
            "bottom": 0
        };
        this.visible = false;
    }

    override protected function showDropdown():void {
        var _loc1_:MovieClip = null;
        var _loc2_:Class = null;
        var _loc3_:Point = null;
        if (dropdown == null) {
            return;
        }
        if (dropdown is String && dropdown != "") {
            _loc2_ = App.utils.classFactory.getClass(dropdown.toString()) as Class;
            if (_loc2_ != null) {
                _loc1_ = App.utils.classFactory.getComponent(dropdown.toString(), CoreList) as CoreList;
            }
        }
        if (_loc1_) {
            if (itemRenderer is String && itemRenderer != "") {
                _loc1_.itemRenderer = App.utils.classFactory.getClass(itemRenderer.toString());
            }
            else if (itemRenderer is Class) {
                _loc1_.itemRenderer = itemRenderer as Class;
            }
            if (scrollBar is String && scrollBar != "") {
                _loc1_.scrollBar = App.utils.classFactory.getClass(scrollBar.toString()) as Class;
            }
            else if (scrollBar is Class) {
                _loc1_.scrollBar = scrollBar as Class;
            }
            _loc1_.selectedIndex = !!TankmanRoleVO(this.data).tankmanID ? 1 : 0;
            _loc1_.width = menuWidth == -1 ? Number(width + menuOffset.left + menuOffset.right) : Number(menuWidth);
            _loc1_.dataProvider = _dataProvider;
            _loc1_.padding = menuPadding;
            _loc1_.wrapping = menuWrapping;
            _loc1_.margin = menuMargin;
            _loc1_.thumbOffset = {
                "top": thumbOffsetTop,
                "bottom": thumbOffsetBottom
            };
            _loc1_.focusTarget = this;
            _loc1_.rowCount = menuRowCount < 1 ? 5 : menuRowCount;
            _loc1_.labelField = _labelField;
            _loc1_.labelFunction = _labelFunction;
            _loc1_.canCleanDataProvider = false;
            _dropdownRef = _loc1_;
            _dropdownRef.name = "dropDownList";
            _dropdownRef.addEventListener(ListEvent.ITEM_CLICK, handleMenuItemClick, false, 0, true);
            _dropdownRef.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL, dropdownRefReadyForTutorialHandler);
            _loc3_ = new Point(x + menuOffset.left, menuDirection == "down" ? Number(y + height + menuOffset.top) : Number(y - _dropdownRef.height + menuOffset.bottom));
            _loc3_ = parent.localToGlobal(_loc3_);
            App.utils.popupMgr.show(_dropdownRef, _loc3_.x, _loc3_.y);
        }
        if (_dropdownRef) {
            dispatchEvent(new CrewDropDownEvent(CrewDropDownEvent.SHOW_DROP_DOWN, _dropdownRef));
        }
    }

    override protected function hideDropdown():void {
        App.toolTipMgr.hide();
        if (_dropdownRef) {
            _dropdownRef.removeEventListener(ListEvent.ITEM_CLICK, handleMenuItemClick, false);
            if (_dropdownRef is IDisposable) {
                IDisposable(_dropdownRef).dispose();
                _dropdownRef.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL, dropdownRefReadyForTutorialHandler);
            }
            App.utils.commons.releaseReferences(_dropdownRef);
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef = null;
        }
    }

    override protected function updateAfterStateChange():void {
        var _loc1_:TankmanRoleVO = null;
        super.updateAfterStateChange();
        if (this.data) {
            _loc1_ = TankmanRoleVO(this.data);
            this.tankmenName.label = _loc1_.tankman.rank + " " + _loc1_.tankman.firstName + " " + _loc1_.tankman.lastName;
            if (_state == "up" || _state == "disabled" || ["out", "toggle", "kb_release"].indexOf(_state) > -1 && !selected) {
                this.tankmenName.label = _loc1_.tankman.rank + " " + _loc1_.tankman.lastName;
            }
        }
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.SELECTED_INDEX) || isInvalid(InvalidationType.DATA)) {
            _dataProvider.requestItemAt(_selectedIndex, populateText);
            invalidateData();
            if (_dataProvider.length > 5) {
                menuPadding.right = 0;
                menuWidth = MENU_WIDTH + SCROLLBAR_PADDING + menuPadding.right + menuPadding.left;
            }
            else {
                menuPadding.right = 4;
                menuWidth = MENU_WIDTH + menuPadding.right + menuPadding.left;
            }
        }
        if (isInvalid(InvalidationType.STATE)) {
            if (_newFrame) {
                gotoAndPlay(_newFrame);
                if (_baseDisposed) {
                    return;
                }
                _newFrame = null;
            }
            if (focusIndicator && _newFocusIndicatorFrame) {
                focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                _newFocusIndicatorFrame = null;
            }
            this.updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA, InvalidationType.SIZE);
        }
        if (isInvalid(InvalidationType.DATA)) {
            updateText();
            if (autoSize != TextFieldAutoSize.NONE) {
                invalidateSize();
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            if (!constraintsDisabled) {
                if (constraints) {
                    constraints.update(_width, _height);
                }
            }
        }
    }

    override protected function onDispose():void {
        removeEventListener(Event.ADDED, addToAutoGroup, false);
        removeEventListener(Event.REMOVED, addToAutoGroup, false);
        removeEventListener(MouseEvent.ROLL_OVER, this.handleMouseRollOver, false);
        removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseRollOut, false);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.handleMousePress, false);
        removeEventListener(MouseEvent.CLICK, this.handleMouseRelease, false);
        removeEventListener(MouseEvent.DOUBLE_CLICK, this.handleMouseRelease, false);
        removeEventListener(InputEvent.INPUT, handleInput, false);
        if (_repeatTimer) {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, beginRepeat, false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER, handleRepeat, false);
        }
        if (_dropdownRef) {
            _dropdownRef.removeEventListener(ListEvent.ITEM_CLICK, handleMenuItemClick, false);
            _dropdownRef.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL, dropdownRefReadyForTutorialHandler);
            if (_dropdownRef is IDisposable) {
                IDisposable(_dropdownRef).dispose();
            }
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef = null;
        }
        if (scrollBar && scrollBar is IDisposable) {
            IDisposable(scrollBar).dispose();
        }
        scrollBar = null;
        this.icon.dispose();
        this.icon = null;
        this.iconRole.dispose();
        this.iconRole = null;
        this.iconRank.dispose();
        this.iconRank = null;
        this.bg = null;
        this.roles.dispose();
        this.roles = null;
        this.skills.dispose();
        this.skills = null;
        this.goups_icons = null;
        this.speed_xp_bg.dispose();
        this.speed_xp_bg = null;
        this.new_skill_anim = null;
        this.levelSpecializationMain.dispose();
        this.levelSpecializationMain = null;
        this.tankmenName.dispose();
        this.tankmenName = null;
        this.rank.dispose();
        this.rank = null;
        this.role.dispose();
        this.role = null;
        this.vehicleType = null;
        this.lastSkillLevel = null;
        this.emptySlotBgAnim = null;
        if (_data && _data is IDisposable) {
            IDisposable(_data).dispose();
            _data = null;
        }
        super.onDispose();
    }

    public function getData():Object {
        return this.data;
    }

    public function openPersonalCase(param1:uint = 0):void {
        dispatchEvent(new CrewEvent(CrewEvent.OPEN_PERSONAL_CASE, this.data, false, param1));
    }

    public function playSound(param1:String):void {
        App.soundMgr.playControlsSnd(param1, this.soundType, this.soundId);
    }

    public function setData(param1:Object):void {
        this.data = param1;
        if (!param1) {
            this.visible = false;
            return;
        }
        this.visible = true;
        var _loc2_:TankmanRoleVO = TankmanRoleVO(param1);
        this.dataProvider = new DataProvider(_loc2_.recruitList);
        var _loc3_:Number = _height * (_loc2_.recruitList.length < menuRowCount ? _loc2_.recruitList.length : menuRowCount);
        var _loc4_:Number = _height / 2 - _loc3_ / 2 - _height;
        var _loc5_:Number = parent.parent.y - y - _height;
        menuOffset.top = Math.round(_loc4_ >= _loc5_ ? Number(_loc4_) : Number(_loc5_)) - 3;
        if (_loc2_.tankman.iconFile != this.icon.source && _loc2_.tankman.iconFile) {
            this.icon.visible = true;
            this.icon.source = TANKMEN_ICONS_SMALL + _loc2_.tankman.iconFile;
        }
        if (_loc2_.tankman.rankIconFile != this.iconRank.imageLoader.source && _loc2_.tankman.rankIconFile) {
            this.iconRank.imageLoader.visible = true;
            this.iconRank.imageLoader.source = TANKMEN_RANKS_SMALL + _loc2_.tankman.rankIconFile;
        }
        else {
            this.iconRank.imageLoader.visible = false;
        }
        if (_loc2_.tankman.roleIconFile != this.iconRole.imageLoader.source && _loc2_.tankman.roleIconFile) {
            this.iconRole.imageLoader.visible = true;
            this.iconRole.imageLoader.source = _loc2_.tankman.roleIconFile;
        }
        var _loc6_:TankmanTextCreator = new TankmanTextCreator(_loc2_.tankman, _loc2_);
        this.role.label = _loc6_.roleHtml;
        this.levelSpecializationMain.label = _loc6_.levelSpecializationMainHtml;
        var _loc7_:Array = [];
        var _loc8_:int = _loc2_.roles.length;
        var _loc9_:int = 0;
        while (_loc9_ < _loc8_) {
            _loc7_.push(new SkillsVO({"icon": TANKMEN_ROLES_SMALL + _loc2_.roles[_loc9_] + IMAGE_EXTENSION}));
            _loc9_++;
        }
        this.roles.dataProvider = new DataProvider(_loc7_);
        this.speed_xp_bg.visible = _loc2_.tankman.isLessMastered;
        if (isNaN(_loc2_.tankmanID) && App.globalVarsMgr.isKoreaS()) {
            this.emptySlotBgAnim.gotoAndPlay(1);
            this.emptySlotBgAnim.visible = true;
        }
        else {
            this.emptySlotBgAnim.gotoAndStop(1);
            this.emptySlotBgAnim.visible = false;
        }
        this.updateSkills(_loc2_.tankman);
        selected = false;
        visible = true;
    }

    public function setListData(param1:ListData):void {
        this.index = param1.index;
        selected = param1.selected;
        label = param1.label || "empty";
    }

    public function updateSkills(param1:TankmanVO):void {
        var _loc2_:int = 0;
        this.skills.dataProvider = new DataProvider(param1.renderSkills);
        if (param1.renderSkills.length > 0) {
            this.new_skill_anim.alpha = 0;
            _loc2_ = !!param1.lastSkillInProgress ? 1 : 0;
            if (param1.needGroupSkills) {
                this.goups_icons.visible = true;
                this.goups_icons.skillsGroupNum.text = "x" + (param1.skills.length - _loc2_);
            }
            else {
                this.goups_icons.visible = false;
            }
            this.lastSkillLevel.text = !!_loc2_ ? param1.lastSkillLevel + "%" : "";
            this.lastSkillLevel.x = this.skills.x + (this.skills.columnWidth + this.skills.paddingRight) * param1.renderSkills.length;
        }
        else {
            this.lastSkillLevel.text = "";
            this.goups_icons.visible = false;
        }
    }

    override public function get data():Object {
        return _data;
    }

    override public function set data(param1:Object):void {
        _data = param1;
    }

    override public function set dataProvider(param1:IDataProvider):void {
        dropdown = param1.length > 1 ? "RecruitScrollingList" : "RecruitScrollingList2";
        menuRowCount = param1.length < 5 ? Number(param1.length) : Number(5);
        if (param1.length > this.menuRowCount) {
            super.scrollBar = "ScrollBar";
        }
        else {
            super.scrollBar = null;
        }
        super.dataProvider = param1;
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function get selectable():Boolean {
        return this._selectable;
    }

    public function set selectable(param1:Boolean):void {
        this._selectable = param1;
    }

    public function get hasData():Boolean {
        var _loc1_:* = !isNaN(TankmanRoleVO(this.data).tankmanID);
        return _loc1_;
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        var _loc4_:int = 0;
        var _loc5_:DisplayObject = null;
        var _loc6_:Number = NaN;
        var _loc2_:ICommons = App.utils.commons;
        var _loc3_:TankmanRoleVO = TankmanRoleVO(this.data);
        if (_loc2_.isLeftButton(param1)) {
            if (this.skills.dataProvider) {
                _loc4_ = 0;
                while (_loc4_ < this.skills.dataProvider.length) {
                    if (this.skills.dataProvider[_loc4_].buy) {
                        _loc5_ = this.skills.getRendererAt(_loc4_) as DisplayObject;
                        _loc6_ = _loc5_.width;
                        if (_loc5_.mouseX > 0 && _loc5_.mouseX < _loc6_ && (_loc5_.mouseY > 0 && _loc5_.mouseY < _loc6_)) {
                            if (selected) {
                                close();
                            }
                            if (_loc3_.tankmanID > 0) {
                                this.openPersonalCase(2);
                                setState("out");
                                return;
                            }
                        }
                    }
                    _loc4_++;
                }
            }
        }
        if (_loc2_.isRightButton(param1)) {
            callLogEvent(param1);
            if (_loc3_.tankmanID > 0 && this.enabled) {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.CREW, this, {"tankmanID": _loc3_.tankmanID});
                App.toolTipMgr.hide();
            }
        }
        super.handleMouseRelease(param1);
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this.playSound("over");
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this.playSound("out");
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        var _loc5_:ButtonEvent = null;
        var _loc2_:MouseEventEx = param1 as MouseEventEx;
        var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
        var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
        if (_loc4_ == 0) {
            _mouseDown = _mouseDown | 1 << _loc3_;
            if (enabled) {
                setState("down");
                if (autoRepeat && _repeatTimer == null) {
                    _autoRepeatEvent = new ButtonEvent(ButtonEvent.CLICK, true, false, _loc3_, _loc4_, false, true);
                    _repeatTimer = new Timer(repeatDelay, 1);
                    _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE, beginRepeat, false, 0, true);
                    _repeatTimer.start();
                }
                _loc5_ = new ButtonEvent(ButtonEvent.PRESS, true, false, _loc3_, _loc4_, false, false);
                dispatchEvent(_loc5_);
                this.playSound("press");
            }
        }
    }

    override protected function canLog():Boolean {
        return false;
    }
}
}
