package net.wg.gui.lobby.hangar {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Directions;
import net.wg.gui.lobby.header.vo.QuestsControlBtnVO;
import net.wg.infrastructure.base.meta.IQuestsControlMeta;
import net.wg.infrastructure.base.meta.impl.QuestsControlMeta;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.exceptions.base.WGGUIException;
import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.utils.helpLayout.HelpLayoutVO;
import net.wg.utils.helpLayout.IHelpLayoutComponent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ComponentEvent;

public class QuestsControl extends QuestsControlMeta implements IQuestsControlMeta, IDAAPIModule, IHelpLayoutComponent {

    public var bg:MovieClip = null;

    public var bagIcon:MovieClip = null;

    private var _disposed:Boolean = false;

    private var _isDAAPIInited:Boolean = false;

    private var _helpLayoutId:String = "";

    private var _tooltipStr:String = "";

    public function QuestsControl() {
        super();
    }

    override protected function onDispose():void {
        this._tooltipStr = null;
        this.bagIcon = null;
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        this._helpLayoutId = null;
        this.bg = null;
        super.onDispose();
    }

    override protected function setData(param1:QuestsControlBtnVO):void {
        this.label = param1.titleText;
        this._tooltipStr = param1.tooltip;
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        mouseChildren = false;
        this.bg.mouseEnabled = false;
        this.bg.mouseChildren = false;
        App.utils.helpLayout.registerComponent(this);
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.STATE)) {
            if (_newFrame) {
                gotoAndPlay(_newFrame);
                _newFrame = null;
            }
            if (focusIndicator && _newFocusIndicatorFrame) {
                focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                _newFocusIndicatorFrame = null;
            }
            updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA, InvalidationType.SIZE);
        }
        if (isInvalid(InvalidationType.DATA)) {
            updateText();
        }
        if (isInvalid(InvalidationType.DATA) && textField) {
            textField.autoSize = TextFieldAutoSize.LEFT;
        }
    }

    override protected function handleClick(param1:uint = 0):void {
        App.toolTipMgr.hide();
        showQuestsWindowS();
        super.handleClick(param1);
    }

    public function as_dispose():void {
        try {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            dispose();
            this._disposed = true;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
            return;
        }
        catch (error:WGGUIException) {
            DebugUtils.LOG_WARNING(error.getStackTrace());
            return;
        }
        catch (error:Error) {
            DebugUtils.LOG_ERROR(error.getStackTrace());
            return;
        }
    }

    public function as_populate():void {
        this._isDAAPIInited = true;
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        if (!this._helpLayoutId) {
            this._helpLayoutId = name + "_" + Math.random();
        }
        var _loc1_:int = 7;
        var _loc2_:int = -2;
        var _loc3_:HelpLayoutVO = new HelpLayoutVO();
        _loc3_.x = _loc1_;
        _loc3_.y = 0;
        _loc3_.width = width;
        _loc3_.height = height + _loc2_;
        _loc3_.extensibilityDirection = Directions.RIGHT;
        _loc3_.message = LOBBY_HELP.HANGAR_QUESTSCONTROL;
        _loc3_.id = this._helpLayoutId;
        _loc3_.scope = this;
        return new <HelpLayoutVO>[_loc3_];
    }

    public function get disposed():Boolean {
        return this._disposed;
    }

    public function get isDAAPIInited():Boolean {
        return this._isDAAPIInited;
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._tooltipStr)) {
            App.toolTipMgr.showComplex(this._tooltipStr);
        }
    }
}
}
