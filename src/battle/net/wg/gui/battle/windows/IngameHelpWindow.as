package net.wg.gui.battle.windows {
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.data.constants.generated.KEYBOARD_KEYS;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.base.meta.IIngameHelpWindowMeta;
import net.wg.infrastructure.base.meta.impl.IngameHelpWindowMeta;
import net.wg.utils.IAssertable;
import net.wg.utils.ICommons;

import scaleform.clik.events.ButtonEvent;

public class IngameHelpWindow extends IngameHelpWindowMeta implements IIngameHelpWindowMeta {

    private var _keysDictionary:Dictionary;

    public var settingsButton:SoundButtonEx = null;

    public var example_time_left:TextField = null;

    public var example_name:TextField = null;

    public var example_hp:TextField = null;

    public var example_hit:TextField = null;

    public var battleControlsTitle:TextField = null;

    public var radialMenuTitle:TextField = null;

    public var chatControlsTitle:TextField = null;

    public var vehicleTypesTitle:TextField = null;

    public var crosshairControlsTitle:TextField = null;

    public var markerColorsTitle:TextField = null;

    public var settingsHelp:TextField = null;

    public var returnToGame:TextField = null;

    public var movementForward:TextField = null;

    public var movementBackward:TextField = null;

    public var movementLeft:TextField = null;

    public var movementRight:TextField = null;

    public var cruiseCtrlForward:TextField = null;

    public var cruiseCtrlBackward:TextField = null;

    public var switchAutorotation:TextField = null;

    public var stopFire:TextField = null;

    public var voiceChatMute:TextField = null;

    public var casseteReload:TextField = null;

    public var fire:TextField = null;

    public var toggleLockTarget:TextField = null;

    public var toggleLockTargetExt:TextField = null;

    public var disableLockTarget:TextField = null;

    public var toggleSniperMode:TextField = null;

    public var toggleSniperModeExt:TextField = null;

    public var togglePlayerPanelModes:TextField = null;

    public var showExPlayerInfo:TextField = null;

    public var hideInterface:TextField = null;

    public var showCursor:TextField = null;

    public var showCursorExt:TextField = null;

    public var makeScreenshort:TextField = null;

    public var radialMenuShow:TextField = null;

    public var radialMenuShowExt:TextField = null;

    public var attackEnemy:TextField = null;

    public var attackEnemyExt:TextField = null;

    public var enterToChatMode:TextField = null;

    public var changetf:TextField = null;

    public var send:TextField = null;

    public var exitFromChatMode:TextField = null;

    public var at_spg:TextField = null;

    public var spg:TextField = null;

    public var light_tank:TextField = null;

    public var medium_tank:TextField = null;

    public var heavy_tank:TextField = null;

    public var friend:TextField = null;

    public var enemy:TextField = null;

    public var teamKiller:TextField = null;

    public var squadPlay:TextField = null;

    public var targetIcon:TextField = null;

    public var targetDistance:TextField = null;

    public var targetLevel:TextField = null;

    public var targetName:TextField = null;

    public var hpIndicator:TextField = null;

    public var hpValues:TextField = null;

    public var targetClass:TextField = null;

    public var damageIndicator:TextField = null;

    public var reloadTimer:TextField = null;

    public var reloadIndicator:TextField = null;

    public var ammoNumber:TextField = null;

    public var marker:TextField = null;

    public var healthPlayer:TextField = null;

    public var dispercion:TextField = null;

    public var gunMarker:TextField = null;

    public var printscreenTF:TextField = null;

    public var enterTF:TextField = null;

    public var tabTF:TextField = null;

    public var enter2TF:TextField = null;

    public var escapeTF:TextField = null;

    public var showCursorTF:TextField = null;

    public var forwardTF:TextField = null;

    public var backwardTF:TextField = null;

    public var leftTF:TextField = null;

    public var rightTF:TextField = null;

    public var forward_cruiseTF:TextField = null;

    public var backward_cruiseTF:TextField = null;

    public var auto_rotationTF:TextField = null;

    public var stop_fireTF:TextField = null;

    public var pushToTalkTF:TextField = null;

    public var reloadPartialClipTF:TextField = null;

    public var fireTF:TextField = null;

    public var lock_targetTF:TextField = null;

    public var lock_target_offTF:TextField = null;

    public var alternate_modeTF:TextField = null;

    public var togglePlayerPanelModesTF:TextField = null;

    public var showExPlayerInfoTF:TextField = null;

    public var showHUDTF:TextField = null;

    public var showRadialMenuTF:TextField = null;

    public var attackTF:TextField = null;

    public function IngameHelpWindow() {
        this._keysDictionary = new Dictionary();
        super();
        isCentered = true;
        canClose = false;
        showWindowBgForm = false;
        showWindowBg = false;
        canDrag = false;
        this._keysDictionary[KEYBOARD_KEYS.FORWARD] = this.forwardTF;
        this._keysDictionary[KEYBOARD_KEYS.BACKWARD] = this.backwardTF;
        this._keysDictionary[KEYBOARD_KEYS.LEFT] = this.leftTF;
        this._keysDictionary[KEYBOARD_KEYS.RIGHT] = this.rightTF;
        this._keysDictionary[KEYBOARD_KEYS.FORWARD_CRUISE] = this.forward_cruiseTF;
        this._keysDictionary[KEYBOARD_KEYS.BACKWARD_CRUISE] = this.backward_cruiseTF;
        this._keysDictionary[KEYBOARD_KEYS.AUTO_ROTATION] = this.auto_rotationTF;
        this._keysDictionary[KEYBOARD_KEYS.STOP_FIRE] = this.stop_fireTF;
        this._keysDictionary[KEYBOARD_KEYS.PUSH_TO_TALK] = this.pushToTalkTF;
        this._keysDictionary[KEYBOARD_KEYS.RELOAD_PARTIAL_CLIP] = this.reloadPartialClipTF;
        this._keysDictionary[KEYBOARD_KEYS.FIRE] = this.fireTF;
        this._keysDictionary[KEYBOARD_KEYS.LOCK_TARGET] = this.lock_targetTF;
        this._keysDictionary[KEYBOARD_KEYS.LOCK_TARGET_OFF] = this.lock_target_offTF;
        this._keysDictionary[KEYBOARD_KEYS.ALTERNATE_MODE] = this.alternate_modeTF;
        this._keysDictionary[KEYBOARD_KEYS.TOGGLE_PLAYER_PANEL_MODES] = this.togglePlayerPanelModesTF;
        this._keysDictionary[KEYBOARD_KEYS.SHOW_EX_PLAYER_INFO] = this.showExPlayerInfoTF;
        this._keysDictionary[KEYBOARD_KEYS.SHOW_HUD] = this.showHUDTF;
        this._keysDictionary[KEYBOARD_KEYS.SHOW_RADIAL_MENU] = this.showRadialMenuTF;
        this._keysDictionary[KEYBOARD_KEYS.ATTACK] = this.attackTF;
    }

    public function as_setKeys(param1:Object):void {
        this.setKeys(param1);
    }

    private function onSettingsBtnClickHandler(param1:ButtonEvent):void {
        clickSettingWindowS();
    }

    private function setKeys(param1:Object):void {
        var _loc2_:TextField = null;
        var _loc3_:* = null;
        var _loc4_:IAssertable = App.utils.asserter;
        var _loc5_:ICommons = App.utils.commons;
        for (_loc3_ in param1) {
            _loc2_ = this._keysDictionary[_loc3_];
            _loc4_.assert(_loc2_ != null, "No " + _loc3_ + " in clip");
            _loc2_.text = _loc5_.keyToString(param1[_loc3_]).keyName;
        }
    }

    private function setTitleTexts():void {
        this.battleControlsTitle.text = INGAME_HELP.BATTLECONTROLS_TITLE;
        this.radialMenuTitle.text = INGAME_HELP.RADIALMENU_TITLE;
        this.chatControlsTitle.text = INGAME_HELP.CHATCONTROLS_TITLE;
        this.vehicleTypesTitle.text = INGAME_HELP.VEHICLETYPES_TITLE;
        this.crosshairControlsTitle.text = INGAME_HELP.CROSSHAIRCONTROLS_TITLE;
        this.markerColorsTitle.text = INGAME_HELP.MARKERCOLORS_TITLE;
        this.settingsHelp.text = INGAME_HELP.SETTINGS_HELP;
        this.returnToGame.text = INGAME_HELP.RETURNTOGAME;
    }

    private function setDescriptionTexts():void {
        this.movementForward.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTFORWARD;
        this.movementBackward.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTBACKWARD;
        this.movementLeft.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTLEFT;
        this.movementRight.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTRIGHT;
        this.cruiseCtrlForward.text = INGAME_HELP.BATTLECONTROLS_CRUISECTRLFORWARD;
        this.cruiseCtrlBackward.text = INGAME_HELP.BATTLECONTROLS_CRUISECTRLBACKWARD;
        this.switchAutorotation.text = INGAME_HELP.BATTLECONTROLS_SWITCHAUTOROTATION;
        this.stopFire.text = INGAME_HELP.BATTLECONTROLS_STOPFIRE;
        this.voiceChatMute.text = INGAME_HELP.BATTLECONTROLS_VOICECHATMUTE;
        this.casseteReload.text = INGAME_HELP.BATTLECONTROLS_CASSETERELOAD;
        this.fire.text = INGAME_HELP.BATTLECONTROLS_FIRE;
        this.toggleLockTarget.text = INGAME_HELP.BATTLECONTROLS_TOGGLELOCKTARGET;
        this.toggleLockTargetExt.text = INGAME_HELP.BATTLECONTROLS_TOGGLELOCKTARGET_EXT;
        this.disableLockTarget.text = INGAME_HELP.BATTLECONTROLS_DISABLELOCKTARGET;
        this.toggleSniperMode.text = INGAME_HELP.BATTLECONTROLS_TOGGLESNIPERMODE;
        this.toggleSniperModeExt.text = INGAME_HELP.BATTLECONTROLS_TOGGLESNIPERMODE_EXT;
        this.togglePlayerPanelModes.text = INGAME_HELP.BATTLECONTROLS_TOGGLEPLAYERPANELMODES;
        this.showExPlayerInfo.text = INGAME_HELP.BATTLECONTROLS_SHOWEXPLAYERINFO;
        this.hideInterface.text = INGAME_HELP.BATTLECONTROLS_HIDEINTERFACE;
        this.showCursor.text = INGAME_HELP.BATTLECONTROLS_SHOWCURSOR;
        this.showCursorExt.text = INGAME_HELP.BATTLECONTROLS_SHOWCURSOR_EXT;
        this.makeScreenshort.text = INGAME_HELP.BATTLECONTROLS_MAKESCREENSHORT;
        this.radialMenuShow.text = INGAME_HELP.RADIALMENU_SHOW;
        this.radialMenuShowExt.text = INGAME_HELP.RADIALMENU_SHOW_EXT;
        this.attackEnemy.text = INGAME_HELP.RADIALMENU_ATTACKENEMY;
        this.attackEnemyExt.text = INGAME_HELP.RADIALMENU_ATTACKENEMY_EXT;
        this.enterToChatMode.text = INGAME_HELP.CHATCONTROLS_ENTERTOCHATMODE;
        this.changetf.text = INGAME_HELP.CHATCONTROLS_CHANGE;
        this.send.text = INGAME_HELP.CHATCONTROLS_SEND;
        this.exitFromChatMode.text = INGAME_HELP.CHATCONTROLS_EXITFROMCHATMODE;
        this.at_spg.text = ITEM_TYPES.VEHICLE_TAGS_AT_SPG_NAME;
        this.spg.text = ITEM_TYPES.VEHICLE_TAGS_SPG_NAME;
        this.light_tank.text = ITEM_TYPES.VEHICLE_TAGS_LIGHT_TANK_NAME;
        this.medium_tank.text = ITEM_TYPES.VEHICLE_TAGS_MEDIUM_TANK_NAME;
        this.heavy_tank.text = ITEM_TYPES.VEHICLE_TAGS_HEAVY_TANK_NAME;
        this.friend.text = INGAME_HELP.MARKERCOLORS_FRIEND;
        this.enemy.text = INGAME_HELP.MARKERCOLORS_ENEMY;
        this.teamKiller.text = INGAME_HELP.MARKERCOLORS_TEAMKILLER;
        this.squadPlay.text = INGAME_HELP.MARKERCOLORS_SQUADPLAYER;
        this.targetIcon.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETICON;
        this.targetDistance.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETDISTANCE;
        this.targetLevel.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETLEVEL;
        this.targetName.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETNAME;
        this.hpIndicator.text = INGAME_HELP.CROSSHAIRCONTROLS_HPINDICATOR;
        this.hpValues.text = INGAME_HELP.CROSSHAIRCONTROLS_HPVALUES;
        this.targetClass.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETCLASS;
        this.damageIndicator.text = INGAME_HELP.CROSSHAIRCONTROLS_DAMAGEINDICATOR;
        this.reloadTimer.text = INGAME_HELP.CROSSHAIRCONTROLS_RELOADTIMER;
        this.reloadIndicator.text = INGAME_HELP.CROSSHAIRCONTROLS_RELOADINDICATOR;
        this.ammoNumber.text = INGAME_HELP.CROSSHAIRCONTROLS_AMMONUMBER;
        this.marker.text = INGAME_HELP.CROSSHAIRCONTROLS_MARKER;
        this.healthPlayer.text = INGAME_HELP.CROSSHAIRCONTROLS_HEALTHPLAYER;
        this.dispercion.text = INGAME_HELP.CROSSHAIRCONTROLS_DISPERCION;
        this.gunMarker.text = INGAME_HELP.CROSSHAIRCONTROLS_GUNMARKER;
    }

    private function setCrossHairTexts():void {
        this.example_time_left.text = INGAME_HELP.CROSSHAIRCONTROLS_TIMELEFT;
        this.example_name.text = INGAME_HELP.CROSSHAIRCONTROLS_EXAMPLE_NAME;
        this.example_hp.text = INGAME_HELP.CROSSHAIRCONTROLS_EXAMPLE_HP;
        this.example_hit.text = INGAME_HELP.CROSSHAIRCONTROLS_EXAMPLE_DAMAGE;
    }

    private function setkeysTexts():void {
        this.settingsButton.label = INGAME_HELP.SETTINGS_BUTTON;
        this.printscreenTF.text = CONTROLS.KEYBOARD_KEY_PRINT_SCREEN;
        this.enterTF.text = CONTROLS.KEYBOARD_KEY_ENTER;
        this.tabTF.text = CONTROLS.KEYBOARD_KEY_TAB;
        this.enter2TF.text = CONTROLS.KEYBOARD_KEY_ENTER;
        this.escapeTF.text = CONTROLS.KEYBOARD_KEY_ESCAPE;
        this.showCursorTF.text = CONTROLS.KEYBOARD_KEY_CTRL_WO_REFERRAL;
    }

    override protected function configUI():void {
        super.configUI();
        this.settingsButton.addEventListener(ButtonEvent.PRESS, this.onSettingsBtnClickHandler);
        this.setTitleTexts();
        this.setDescriptionTexts();
        this.setCrossHairTexts();
        this.setkeysTexts();
    }

    override protected function onDispose():void {
        this.settingsButton.removeEventListener(ButtonEvent.PRESS, this.onSettingsBtnClickHandler);
        this.settingsButton.dispose();
        this.settingsButton = null;
        this._keysDictionary = null;
        this.example_time_left = null;
        this.example_name = null;
        this.example_hp = null;
        this.example_hit = null;
        this.battleControlsTitle = null;
        this.radialMenuTitle = null;
        this.chatControlsTitle = null;
        this.vehicleTypesTitle = null;
        this.crosshairControlsTitle = null;
        this.markerColorsTitle = null;
        this.settingsHelp = null;
        this.returnToGame = null;
        this.movementForward = null;
        this.movementBackward = null;
        this.movementLeft = null;
        this.movementRight = null;
        this.cruiseCtrlForward = null;
        this.cruiseCtrlBackward = null;
        this.switchAutorotation = null;
        this.stopFire = null;
        this.voiceChatMute = null;
        this.casseteReload = null;
        this.fire = null;
        this.toggleLockTarget = null;
        this.toggleLockTargetExt = null;
        this.disableLockTarget = null;
        this.toggleSniperMode = null;
        this.toggleSniperModeExt = null;
        this.togglePlayerPanelModes = null;
        this.showExPlayerInfo = null;
        this.hideInterface = null;
        this.showCursor = null;
        this.showCursorExt = null;
        this.makeScreenshort = null;
        this.radialMenuShow = null;
        this.radialMenuShowExt = null;
        this.attackEnemy = null;
        this.attackEnemyExt = null;
        this.enterToChatMode = null;
        this.changetf = null;
        this.send = null;
        this.exitFromChatMode = null;
        this.at_spg = null;
        this.spg = null;
        this.light_tank = null;
        this.medium_tank = null;
        this.heavy_tank = null;
        this.friend = null;
        this.enemy = null;
        this.teamKiller = null;
        this.squadPlay = null;
        this.targetIcon = null;
        this.targetDistance = null;
        this.targetLevel = null;
        this.targetName = null;
        this.hpIndicator = null;
        this.hpValues = null;
        this.targetClass = null;
        this.damageIndicator = null;
        this.reloadTimer = null;
        this.reloadIndicator = null;
        this.ammoNumber = null;
        this.marker = null;
        this.healthPlayer = null;
        this.dispercion = null;
        this.gunMarker = null;
        this.printscreenTF = null;
        this.enterTF = null;
        this.tabTF = null;
        this.enter2TF = null;
        this.escapeTF = null;
        this.showCursorTF = null;
        this.forwardTF = null;
        this.backwardTF = null;
        this.leftTF = null;
        this.rightTF = null;
        this.forward_cruiseTF = null;
        this.backward_cruiseTF = null;
        this.auto_rotationTF = null;
        this.stop_fireTF = null;
        this.pushToTalkTF = null;
        this.reloadPartialClipTF = null;
        this.fireTF = null;
        this.lock_targetTF = null;
        this.lock_target_offTF = null;
        this.alternate_modeTF = null;
        this.togglePlayerPanelModesTF = null;
        this.showExPlayerInfoTF = null;
        this.showHUDTF = null;
        this.showRadialMenuTF = null;
        this.attackTF = null;
        super.onDispose();
    }
}
}
