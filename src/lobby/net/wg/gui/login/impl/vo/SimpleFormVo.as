package net.wg.gui.login.impl.vo {
public class SimpleFormVo extends FormBaseVo {

    public var memberMe:Boolean = false;

    public var memberMeVisible:Boolean = false;

    public var loginName:String = "";

    public var pwd:String = "";

    public var isIgrCredentialsReset:Boolean = false;

    public var showRecoveryLink:Boolean = false;

    public var autoLoginKey:String = "";

    public var capsLockState:Boolean = false;

    public var keyboardLang:String = "";

    public var isShowSocial:Boolean = false;

    public var socialList:Array = null;

    public function SimpleFormVo() {
        super();
    }

    override public function dispose():void {
        App.utils.data.cleanupDynamicObject(this.socialList);
        super.dispose();
    }
}
}
