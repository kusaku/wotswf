package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

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

    public function PersonalCaseMeta() {
        super();
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
}
}
