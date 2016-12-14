package net.wg.gui.data {
import net.wg.data.VO.AchievementItemVO;
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class AwardWindowVO extends DAAPIDataClass {

    private static const FIELD_ACHIEVEMENTS:String = "achievements";

    private static const AWARDS_BLOCK:String = "awardsBlock";

    private static const BACK_ANIMATION_DATA:String = "backAnimationData";

    private static const HEADER_TEXT_OFFSET:int = 269;

    private static const MIN_WINDOW_HEIGHT:int = 427;

    private static const BOTTOM_BUTTONS_PADDING:uint = 23;

    public var backImage:String = "";

    public var awardImage:String = "";

    public var packImage:String = "";

    public var forceUseBackImage:Boolean = false;

    public var useBackAnimation:Boolean = false;

    public var backAnimationData:AwardWindowAnimationVO;

    public var useEndedBackAnimation:Boolean = false;

    public var autoControlBackAnimation:Boolean = true;

    public var windowTitle:String = "";

    public var header:String = "";

    public var description:String = "";

    public var additionalText:String = "";

    public var buttonText:String = "";

    public var isOKBtnEnabled:Boolean = true;

    public var isCloseBtnEnabled:Boolean = false;

    public var isDashLineEnabled:Boolean = true;

    public var achievements:Array;

    public var textAreaIconPath:String = "";

    public var textAreaIconIsShow:Boolean = false;

    public var awardsBlock:TaskAwardsBlockVO = null;

    public var hasCheckBox:Boolean = false;

    public var isCheckBoxSelected:Boolean = false;

    public var checkBoxLabel:String = "";

    public var closeBtnLabel:String = "";

    public var warningText:String = "";

    public var warningHyperlinkText:String = "";

    public var minWindowHeight:int = 427;

    public var headerTextOffset:int = 269;

    public var bottomButtonsPadding:int = 23;

    public function AwardWindowVO(param1:Object) {
        this.achievements = [];
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        var _loc5_:AchievementItemVO = null;
        if (param1 == FIELD_ACHIEVEMENTS) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, param1 + Errors.CANT_NULL);
            this.achievements = [];
            for each(_loc4_ in _loc3_) {
                _loc5_ = !!_loc4_ ? new AchievementItemVO(_loc4_) : null;
                this.achievements.push(_loc5_);
            }
            return false;
        }
        if (param1 == AWARDS_BLOCK) {
            this.awardsBlock = new TaskAwardsBlockVO(param2);
            return false;
        }
        if (param1 == BACK_ANIMATION_DATA && param2 != null) {
            this.backAnimationData = new AwardWindowAnimationVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.disposeAchievements();
        if (this.awardsBlock != null) {
            this.awardsBlock.dispose();
            this.awardsBlock = null;
        }
        if (this.backAnimationData != null) {
            this.backAnimationData.dispose();
            this.backAnimationData = null;
        }
        super.onDispose();
    }

    private function disposeAchievements():void {
        var _loc1_:IDisposable = null;
        if (this.achievements.length > 0) {
            for each(_loc1_ in this.achievements) {
                if (_loc1_) {
                    _loc1_.dispose();
                }
            }
            this.achievements.splice(0);
            this.achievements = null;
        }
    }

    public function get hasAchievements():Boolean {
        return this.achievements && this.achievements.length > 0;
    }

    public function get animationData():StoppableAnimationLoaderVO {
        if (this.backAnimationData != null) {
            return this.backAnimationData.animationData;
        }
        return null;
    }
}
}
