package net.wg.gui.lobby.modulesPanel.components {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.lobby.modulesPanel.data.ModuleVO;
import net.wg.infrastructure.events.IconLoaderEvent;

import org.idmedia.as3commons.util.StringUtils;

public class ModuleFittingItemRenderer extends FittingListItemRenderer {

    private static const EXTRA_ICON_X:int = 9;

    private static const EXTRA_ICON_Y:int = 15;

    private static const EXTRA_ICON_OFFSET_X:Number = 39;

    private static const EXTRA_ICON_OFFSET_Y:Number = 14;

    public var levelIcon:MovieClip;

    public var paramValuesField:TextField;

    public var paramNamesField:TextField;

    private var _extraIcon:ExtraIcon;

    private var _moduleData:ModuleVO;

    public function ModuleFittingItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._moduleData = ModuleVO(param1);
    }

    override protected function onDispose():void {
        if (this._extraIcon != null) {
            this._extraIcon.dispose();
            this._extraIcon = null;
        }
        this.levelIcon = null;
        this.paramValuesField = null;
        this.paramNamesField = null;
        this._moduleData = null;
        super.onDispose();
    }

    override protected function onBeforeDispose():void {
        if (this._extraIcon != null) {
            this._extraIcon.removeEventListener(IconLoaderEvent.ICON_LOADED, this.onExtraIconIconLoadedHandler);
        }
        super.onBeforeDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.levelIcon.mouseEnabled = this.levelIcon.mouseChildren = false;
        this.paramValuesField.mouseEnabled = false;
        this.paramNamesField.mouseEnabled = false;
    }

    override protected function setup():void {
        super.setup();
        if (this._moduleData != null) {
            this.paramNamesField.htmlText = this._moduleData.paramNames;
            this.paramValuesField.htmlText = this._moduleData.paramValues;
            this.levelIcon.gotoAndStop(this._moduleData.level);
            App.utils.commons.updateTextFieldSize(this.paramValuesField, false, true);
            App.utils.commons.updateTextFieldSize(this.paramNamesField, false, true);
            layoutErrorField(this.paramNamesField);
            if (StringUtils.isNotEmpty(this._moduleData.extraModuleInfo)) {
                if (this._extraIcon == null) {
                    this.createExtraIcon();
                }
                this._extraIcon.setSource(this._moduleData.extraModuleInfo);
            }
            else if (this._extraIcon != null) {
                this._extraIcon.clear();
            }
        }
    }

    protected function createExtraIcon():void {
        this._extraIcon = new ExtraIcon();
        this._extraIcon.addEventListener(IconLoaderEvent.ICON_LOADED, this.onExtraIconIconLoadedHandler, false, 0, true);
        this._extraIcon.mouseChildren = false;
        this._extraIcon.mouseEnabled = false;
        addChild(this._extraIcon);
    }

    private function onExtraIconIconLoadedHandler(param1:IconLoaderEvent):void {
        if (this.levelIcon != null) {
            this._extraIcon.x = this.levelIcon.x + EXTRA_ICON_OFFSET_X | 0;
            this._extraIcon.y = this.levelIcon.y + this.levelIcon.height + EXTRA_ICON_OFFSET_Y | 0;
        }
        else {
            this._extraIcon.x = EXTRA_ICON_X;
            this._extraIcon.y = EXTRA_ICON_Y;
        }
    }
}
}
