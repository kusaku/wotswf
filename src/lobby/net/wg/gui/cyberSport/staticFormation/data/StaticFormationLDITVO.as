package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.VO.ILditInfo;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.data.managers.IToolTipParams;

public class StaticFormationLDITVO extends DAAPIDataClass implements ILditInfo {

    private var _text:String = "";

    private var _description:String = "";

    private var _iconPath:String = "";

    private var _tooltip:String = "";

    private var _enabled:Boolean = true;

    public function StaticFormationLDITVO(param1:Object) {
        super(param1);
    }

    public function get description():String {
        return this._description;
    }

    public function set description(param1:String):void {
        this._description = param1;
    }

    public function get iconPath():String {
        return this._iconPath;
    }

    public function set iconPath(param1:String):void {
        this._iconPath = param1;
    }

    public function get text():String {
        return this._text;
    }

    public function set text(param1:String):void {
        this._text = param1;
    }

    public function get tooltip():String {
        return this._tooltip;
    }

    public function set tooltip(param1:String):void {
        this._tooltip = param1;
    }

    public function get toolTipParams():IToolTipParams {
        return null;
    }

    public function set toolTipParams(param1:IToolTipParams):void {
    }

    public function get enabled():Boolean {
        return this._enabled;
    }

    public function set enabled(param1:Boolean):void {
        this._enabled = param1;
    }

    override protected function onDispose():void {
        this._text = null;
        this._description = null;
        this._iconPath = null;
        this._tooltip = null;
        super.onDispose();
    }
}
}
