package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StaticFormationStatsVO extends DAAPIDataClass {

    private static const BATTLES_NUM_DATA:String = "battlesNumData";

    private static const WINS_PERCENT_DATA:String = "winsPercentData";

    private static const WINS_BY_CAPTURE_DATA:String = "winsByCaptureData";

    private static const TEACH_DEFEATS_DATA:String = "techDefeatsData";

    private static const LEFT_STATS:String = "leftStats";

    private static const CENTER_STATS:String = "centerStats";

    private static const RIGHT_STATS:String = "rightStats";

    private var _battlesNumData:StaticFormationLDITVO = null;

    private var _winsPercentData:StaticFormationLDITVO = null;

    private var _winsByCaptureData:StaticFormationLDITVO = null;

    private var _techDefeatsData:StaticFormationLDITVO = null;

    private var _leftStats:Vector.<StaticFormationStatsItemVO> = null;

    private var _centerStats:Vector.<StaticFormationStatsItemVO> = null;

    private var _rightStats:Vector.<StaticFormationStatsItemVO> = null;

    public function StaticFormationStatsVO(param1:Object) {
        super(param1);
    }

    private static function disposeStatsVector(param1:Vector.<StaticFormationStatsItemVO>):void {
        var _loc2_:IDisposable = null;
        for each(_loc2_ in param1) {
            _loc2_.dispose();
        }
        param1.splice(0, param1.length);
    }

    private static function createStatsVector(param1:Object, param2:String):Vector.<StaticFormationStatsItemVO> {
        var _loc5_:Object = null;
        var _loc3_:Vector.<StaticFormationStatsItemVO> = new Vector.<StaticFormationStatsItemVO>(0);
        var _loc4_:Array = param1 as Array;
        App.utils.asserter.assertNotNull(_loc4_, param2 + Errors.CANT_NULL);
        for each(_loc5_ in _loc4_) {
            _loc3_.push(new StaticFormationStatsItemVO(_loc5_));
        }
        return _loc3_;
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case BATTLES_NUM_DATA:
                this._battlesNumData = new StaticFormationLDITVO(param2);
                return false;
            case WINS_PERCENT_DATA:
                this._winsPercentData = new StaticFormationLDITVO(param2);
                return false;
            case WINS_BY_CAPTURE_DATA:
                this._winsByCaptureData = new StaticFormationLDITVO(param2);
                return false;
            case TEACH_DEFEATS_DATA:
                this._techDefeatsData = new StaticFormationLDITVO(param2);
                return false;
            case LEFT_STATS:
                this._leftStats = createStatsVector(param2, LEFT_STATS);
                return false;
            case CENTER_STATS:
                this._centerStats = createStatsVector(param2, CENTER_STATS);
                return false;
            case RIGHT_STATS:
                this._rightStats = createStatsVector(param2, RIGHT_STATS);
                return false;
            default:
                return true;
        }
    }

    override protected function onDispose():void {
        this._battlesNumData.dispose();
        this._battlesNumData = null;
        this._winsPercentData.dispose();
        this._winsPercentData = null;
        this._winsByCaptureData.dispose();
        this._winsByCaptureData = null;
        this._techDefeatsData.dispose();
        this._techDefeatsData = null;
        disposeStatsVector(this._leftStats);
        this._leftStats = null;
        disposeStatsVector(this._centerStats);
        this._centerStats = null;
        disposeStatsVector(this._rightStats);
        this._rightStats = null;
        super.onDispose();
    }

    public function get battlesNumData():StaticFormationLDITVO {
        return this._battlesNumData;
    }

    public function get winsPercentData():StaticFormationLDITVO {
        return this._winsPercentData;
    }

    public function get winsByCaptureData():StaticFormationLDITVO {
        return this._winsByCaptureData;
    }

    public function get techDefeatsData():StaticFormationLDITVO {
        return this._techDefeatsData;
    }

    public function get leftStats():Vector.<StaticFormationStatsItemVO> {
        return this._leftStats;
    }

    public function get centerStats():Vector.<StaticFormationStatsItemVO> {
        return this._centerStats;
    }

    public function get rightStats():Vector.<StaticFormationStatsItemVO> {
        return this._rightStats;
    }
}
}
