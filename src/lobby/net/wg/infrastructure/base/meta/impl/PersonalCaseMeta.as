package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.tankman.PersonalCaseDocsModel;
import net.wg.gui.lobby.tankman.PersonalCaseModel;
import net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class PersonalCaseMeta extends AbstractWindowView {

    public var dismissTankman:Function;

    public var unloadTankman:Function;

    public var getCommonData:Function;

    public var getDossierData:Function;

    public var getRetrainingData:Function;

    public var retrainingTankman:Function;

    public var getSkillsData:Function;

    public var getDocumentsData:Function;

    public var addTankmanSkill:Function;

    public var dropSkills:Function;

    public var changeTankmanPassport:Function;

    public var openExchangeFreeToTankmanXpWindow:Function;

    public var openChangeRoleWindow:Function;

    private var _array:Array;

    private var _personalCaseDocsModel:PersonalCaseDocsModel;

    private var _personalCaseModel:PersonalCaseModel;

    private var _personalCaseRetrainingModel:PersonalCaseRetrainingModel;

    public function PersonalCaseMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        if (this._personalCaseDocsModel) {
            this._personalCaseDocsModel.dispose();
            this._personalCaseDocsModel = null;
        }
        if (this._personalCaseModel) {
            this._personalCaseModel.dispose();
            this._personalCaseModel = null;
        }
        if (this._personalCaseRetrainingModel) {
            this._personalCaseRetrainingModel.dispose();
            this._personalCaseRetrainingModel = null;
        }
        super.onDispose();
    }

    public function dismissTankmanS(param1:int):void {
        App.utils.asserter.assertNotNull(this.dismissTankman, "dismissTankman" + Errors.CANT_NULL);
        this.dismissTankman(param1);
    }

    public function unloadTankmanS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.unloadTankman, "unloadTankman" + Errors.CANT_NULL);
        this.unloadTankman(param1, param2);
    }

    public function getCommonDataS():void {
        App.utils.asserter.assertNotNull(this.getCommonData, "getCommonData" + Errors.CANT_NULL);
        this.getCommonData();
    }

    public function getDossierDataS():void {
        App.utils.asserter.assertNotNull(this.getDossierData, "getDossierData" + Errors.CANT_NULL);
        this.getDossierData();
    }

    public function getRetrainingDataS():void {
        App.utils.asserter.assertNotNull(this.getRetrainingData, "getRetrainingData" + Errors.CANT_NULL);
        this.getRetrainingData();
    }

    public function retrainingTankmanS(param1:int, param2:int, param3:int):void {
        App.utils.asserter.assertNotNull(this.retrainingTankman, "retrainingTankman" + Errors.CANT_NULL);
        this.retrainingTankman(param1, param2, param3);
    }

    public function getSkillsDataS():void {
        App.utils.asserter.assertNotNull(this.getSkillsData, "getSkillsData" + Errors.CANT_NULL);
        this.getSkillsData();
    }

    public function getDocumentsDataS():void {
        App.utils.asserter.assertNotNull(this.getDocumentsData, "getDocumentsData" + Errors.CANT_NULL);
        this.getDocumentsData();
    }

    public function addTankmanSkillS(param1:int, param2:String):void {
        App.utils.asserter.assertNotNull(this.addTankmanSkill, "addTankmanSkill" + Errors.CANT_NULL);
        this.addTankmanSkill(param1, param2);
    }

    public function dropSkillsS():void {
        App.utils.asserter.assertNotNull(this.dropSkills, "dropSkills" + Errors.CANT_NULL);
        this.dropSkills();
    }

    public function changeTankmanPassportS(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int):void {
        App.utils.asserter.assertNotNull(this.changeTankmanPassport, "changeTankmanPassport" + Errors.CANT_NULL);
        this.changeTankmanPassport(param1, param2, param3, param4, param5, param6, param7);
    }

    public function openExchangeFreeToTankmanXpWindowS():void {
        App.utils.asserter.assertNotNull(this.openExchangeFreeToTankmanXpWindow, "openExchangeFreeToTankmanXpWindow" + Errors.CANT_NULL);
        this.openExchangeFreeToTankmanXpWindow();
    }

    public function openChangeRoleWindowS():void {
        App.utils.asserter.assertNotNull(this.openChangeRoleWindow, "openChangeRoleWindow" + Errors.CANT_NULL);
        this.openChangeRoleWindow();
    }

    public final function as_setCommonData(param1:Object):void {
        var _loc2_:PersonalCaseModel = this._personalCaseModel;
        this._personalCaseModel = new PersonalCaseModel(param1);
        this.setCommonData(this._personalCaseModel);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setRetrainingData(param1:Object):void {
        var _loc2_:PersonalCaseRetrainingModel = this._personalCaseRetrainingModel;
        this._personalCaseRetrainingModel = new PersonalCaseRetrainingModel(param1);
        this.setRetrainingData(this._personalCaseRetrainingModel);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setSkillsData(param1:Array):void {
        var _loc2_:Array = this._array;
        this._array = param1;
        this.setSkillsData(this._array);
        if (_loc2_) {
            _loc2_.splice(0, _loc2_.length);
        }
    }

    public final function as_setDocumentsData(param1:Object):void {
        var _loc2_:PersonalCaseDocsModel = this._personalCaseDocsModel;
        this._personalCaseDocsModel = new PersonalCaseDocsModel(param1);
        this.setDocumentsData(this._personalCaseDocsModel);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setCommonData(param1:PersonalCaseModel):void {
        var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setRetrainingData(param1:PersonalCaseRetrainingModel):void {
        var _loc2_:String = "as_setRetrainingData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setSkillsData(param1:Array):void {
        var _loc2_:String = "as_setSkillsData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setDocumentsData(param1:PersonalCaseDocsModel):void {
        var _loc2_:String = "as_setDocumentsData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
