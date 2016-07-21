package net.wg.gui.settings {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.RangeSlider;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.settings.components.RadioButtonBar;
import net.wg.gui.settings.components.SettingsStepSlider;
import net.wg.gui.settings.config.SettingsConfigHelper;

public class GraphicSettingsBase extends SettingsBaseView {

    public var tabs:ContentTabBar;

    public var screenForm:ScreenSettingsForm;

    public var advancedForm:AdvancedGraphicSettingsForm;

    public var lip:MovieClip;

    public var graphicsQualityLabel:LabelControl = null;

    public var graphicsQualityDropDown:DropdownMenu = null;

    public var autodetectQuality:SoundButtonEx = null;

    public var graphicsQualityHDSD:TextField = null;

    public var dynamicRendererLabel:LabelControl = null;

    public var dynamicRendererSlider:Slider = null;

    public var dynamicRendererValue:LabelControl = null;

    public var monitorLabel:LabelControl = null;

    public var monitorDropDown:DropdownMenu = null;

    public var fullScreenCheckbox:CheckBox = null;

    public var sizesLabel:LabelControl = null;

    public var sizesDropDown:DropdownMenu = null;

    public var refreshRateLabel:LabelControl = null;

    public var refreshRateDropDown:DropdownMenu = null;

    public var vertSyncCheckbox:CheckBox = null;

    public var tripleBufferedCheckbox:CheckBox = null;

    public var aspectRatioLabel:LabelControl = null;

    public var aspectRatioDropDown:DropdownMenu = null;

    public var interfaceScaleLabel:LabelControl = null;

    public var interfaceScaleDropDown:DropdownMenu = null;

    public var smoothingLabel:LabelControl = null;

    public var smoothingDropDown:DropdownMenu = null;

    public var gammaLabel:LabelControl = null;

    public var gammaSlider:Slider = null;

    public var colorFilterIntensityLabel:LabelControl = null;

    public var colorFilterIntensitySlider:Slider = null;

    public var colorFilterIntensityValue:LabelControl = null;

    public var isColorBlindCheckbox:CheckBox = null;

    public var colorFilterDefaultImg:UILoaderAlt = null;

    public var colorFilterOverlayImg:UILoaderAlt = null;

    public var COLOR_GRADING_TECHNIQUELabel:LabelControl = null;

    public var COLOR_GRADING_TECHNIQUEDropDown:DropdownMenu = null;

    public var fovLabel:LabelControl = null;

    public var fovRangeSlider:RangeSlider = null;

    public var dynamicFovCheckbox:CheckBox = null;

    public var HAVOK_ENABLEDLabel:LabelControl = null;

    public var HAVOK_ENABLEDDropDown:DropdownMenu = null;

    public var RENDER_PIPELINELabel:LabelControl = null;

    public var RENDER_PIPELINEButtonBar:RadioButtonBar = null;

    public var TEXTURE_QUALITYLabel:LabelControl = null;

    public var TEXTURE_QUALITYValue:LabelControl = null;

    public var TEXTURE_QUALITYStepSlider:SettingsStepSlider = null;

    public var SHADOWS_QUALITYLabel:LabelControl = null;

    public var SHADOWS_QUALITYValue:LabelControl = null;

    public var SHADOWS_QUALITYStepSlider:SettingsStepSlider = null;

    public var DECALS_QUALITYLabel:LabelControl = null;

    public var DECALS_QUALITYValue:LabelControl = null;

    public var DECALS_QUALITYStepSlider:SettingsStepSlider = null;

    public var TERRAIN_QUALITYLabel:LabelControl = null;

    public var TERRAIN_QUALITYValue:LabelControl = null;

    public var TERRAIN_QUALITYStepSlider:SettingsStepSlider = null;

    public var WATER_QUALITYLabel:LabelControl = null;

    public var WATER_QUALITYValue:LabelControl = null;

    public var WATER_QUALITYStepSlider:SettingsStepSlider = null;

    public var LIGHTING_QUALITYLabel:LabelControl = null;

    public var LIGHTING_QUALITYValue:LabelControl = null;

    public var LIGHTING_QUALITYStepSlider:SettingsStepSlider = null;

    public var SPEEDTREE_QUALITYLabel:LabelControl = null;

    public var SPEEDTREE_QUALITYValue:LabelControl = null;

    public var SPEEDTREE_QUALITYStepSlider:SettingsStepSlider = null;

    public var FLORA_QUALITYLabel:LabelControl = null;

    public var FLORA_QUALITYValue:LabelControl = null;

    public var FLORA_QUALITYStepSlider:SettingsStepSlider = null;

    public var EFFECTS_QUALITYLabel:LabelControl = null;

    public var EFFECTS_QUALITYValue:LabelControl = null;

    public var EFFECTS_QUALITYStepSlider:SettingsStepSlider = null;

    public var POST_PROCESSING_QUALITYLabel:LabelControl = null;

    public var POST_PROCESSING_QUALITYValue:LabelControl = null;

    public var POST_PROCESSING_QUALITYStepSlider:SettingsStepSlider = null;

    public var MOTION_BLUR_QUALITYLabel:LabelControl = null;

    public var MOTION_BLUR_QUALITYValue:LabelControl = null;

    public var MOTION_BLUR_QUALITYStepSlider:SettingsStepSlider = null;

    public var FAR_PLANELabel:LabelControl = null;

    public var FAR_PLANEValue:LabelControl = null;

    public var FAR_PLANEStepSlider:SettingsStepSlider = null;

    public var OBJECT_LODLabel:LabelControl = null;

    public var OBJECT_LODValue:LabelControl = null;

    public var OBJECT_LODStepSlider:SettingsStepSlider = null;

    public var SNIPER_MODE_EFFECTS_QUALITYLabel:LabelControl = null;

    public var SNIPER_MODE_EFFECTS_QUALITYValue:LabelControl = null;

    public var SNIPER_MODE_EFFECTS_QUALITYStepSlider:SettingsStepSlider = null;

    public var fpsPerfomancerCheckbox:CheckBox = null;

    public var SNIPER_MODE_GRASS_ENABLEDCheckbox:CheckBox = null;

    public var VEHICLE_DUST_ENABLEDCheckbox:CheckBox = null;

    public var VEHICLE_TRACES_ENABLEDCheckbox:CheckBox = null;

    public var SEMITRANSPARENT_LEAVES_ENABLEDCheckbox:CheckBox = null;

    public var DRR_AUTOSCALER_ENABLEDCheckbox:CheckBox = null;

    protected var _isFullScreen:Boolean = false;

    public function GraphicSettingsBase() {
        super();
        this.initControls();
    }

    override protected function configUI():void {
        super.configUI();
        this.lip.mouseChildren = this.lip.mouseEnabled = false;
        this.graphicsQualityHDSD.visible = false;
        this.initToolTipMapping();
    }

    override protected function getControlId(param1:DisplayObject):String {
        var _loc2_:String = super.getControlId(param1);
        if (_loc2_ == SettingsConfigHelper.SIZE) {
            return !!this._isFullScreen ? SettingsConfigHelper.RESOLUTION : SettingsConfigHelper.WINDOW_SIZE;
        }
        return _loc2_;
    }

    override protected function onDispose():void {
        this.monitorLabel = null;
        this.monitorDropDown = null;
        this.fullScreenCheckbox = null;
        this.sizesLabel = null;
        this.sizesDropDown = null;
        this.refreshRateLabel = null;
        this.refreshRateDropDown = null;
        this.vertSyncCheckbox = null;
        this.tripleBufferedCheckbox = null;
        this.aspectRatioLabel = null;
        this.aspectRatioDropDown = null;
        this.interfaceScaleLabel = null;
        this.interfaceScaleDropDown = null;
        this.smoothingLabel = null;
        this.smoothingDropDown = null;
        this.gammaLabel = null;
        this.gammaSlider = null;
        this.colorFilterIntensityLabel = null;
        this.colorFilterIntensitySlider = null;
        this.colorFilterIntensityValue = null;
        this.isColorBlindCheckbox = null;
        this.colorFilterDefaultImg = null;
        this.colorFilterOverlayImg = null;
        this.COLOR_GRADING_TECHNIQUELabel = null;
        this.COLOR_GRADING_TECHNIQUEDropDown = null;
        this.fovLabel = null;
        this.fovRangeSlider = null;
        this.dynamicFovCheckbox = null;
        this.RENDER_PIPELINELabel = null;
        this.RENDER_PIPELINEButtonBar = null;
        this.TEXTURE_QUALITYLabel = null;
        this.TEXTURE_QUALITYValue = null;
        this.TEXTURE_QUALITYStepSlider = null;
        this.SHADOWS_QUALITYLabel = null;
        this.SHADOWS_QUALITYValue = null;
        this.SHADOWS_QUALITYStepSlider = null;
        this.DECALS_QUALITYLabel = null;
        this.DECALS_QUALITYValue = null;
        this.DECALS_QUALITYStepSlider = null;
        this.TERRAIN_QUALITYLabel = null;
        this.TERRAIN_QUALITYValue = null;
        this.TERRAIN_QUALITYStepSlider = null;
        this.WATER_QUALITYLabel = null;
        this.WATER_QUALITYValue = null;
        this.WATER_QUALITYStepSlider = null;
        this.LIGHTING_QUALITYLabel = null;
        this.LIGHTING_QUALITYValue = null;
        this.LIGHTING_QUALITYStepSlider = null;
        this.SPEEDTREE_QUALITYLabel = null;
        this.SPEEDTREE_QUALITYValue = null;
        this.SPEEDTREE_QUALITYStepSlider = null;
        this.FLORA_QUALITYLabel = null;
        this.FLORA_QUALITYValue = null;
        this.FLORA_QUALITYStepSlider = null;
        this.EFFECTS_QUALITYLabel = null;
        this.EFFECTS_QUALITYValue = null;
        this.EFFECTS_QUALITYStepSlider = null;
        this.POST_PROCESSING_QUALITYLabel = null;
        this.POST_PROCESSING_QUALITYValue = null;
        this.POST_PROCESSING_QUALITYStepSlider = null;
        this.MOTION_BLUR_QUALITYLabel = null;
        this.MOTION_BLUR_QUALITYValue = null;
        this.MOTION_BLUR_QUALITYStepSlider = null;
        this.FAR_PLANELabel = null;
        this.FAR_PLANEValue = null;
        this.FAR_PLANEStepSlider = null;
        this.OBJECT_LODLabel = null;
        this.OBJECT_LODValue = null;
        this.OBJECT_LODStepSlider = null;
        this.SNIPER_MODE_EFFECTS_QUALITYLabel = null;
        this.SNIPER_MODE_EFFECTS_QUALITYValue = null;
        this.SNIPER_MODE_EFFECTS_QUALITYStepSlider = null;
        this.fpsPerfomancerCheckbox = null;
        this.SNIPER_MODE_GRASS_ENABLEDCheckbox = null;
        this.VEHICLE_DUST_ENABLEDCheckbox = null;
        this.VEHICLE_TRACES_ENABLEDCheckbox = null;
        this.SEMITRANSPARENT_LEAVES_ENABLEDCheckbox = null;
        this.tabs.dispose();
        this.tabs = null;
        this.screenForm.dispose();
        this.screenForm = null;
        this.advancedForm.dispose();
        this.advancedForm = null;
        this.graphicsQualityLabel.dispose();
        this.graphicsQualityLabel = null;
        this.graphicsQualityDropDown.dispose();
        this.graphicsQualityDropDown = null;
        this.autodetectQuality.dispose();
        this.autodetectQuality = null;
        this.graphicsQualityHDSD = null;
        this.dynamicRendererLabel.dispose();
        this.dynamicRendererLabel = null;
        this.dynamicRendererSlider.dispose();
        this.dynamicRendererSlider = null;
        this.dynamicRendererValue.dispose();
        this.dynamicRendererValue = null;
        this.DRR_AUTOSCALER_ENABLEDCheckbox.dispose();
        this.DRR_AUTOSCALER_ENABLEDCheckbox = null;
        this.lip = null;
        super.onDispose();
    }

    private function initToolTipMapping():void {
        registerToolTip(this.graphicsQualityDropDown, SettingsConfigHelper.GRAPHIC_QUALITY);
        registerToolTip(this.graphicsQualityLabel, SettingsConfigHelper.GRAPHIC_QUALITY);
        registerToolTip(this.dynamicRendererSlider, SettingsConfigHelper.DYNAMIC_RENDERER);
        registerToolTip(this.dynamicRendererLabel, SettingsConfigHelper.DYNAMIC_RENDERER);
        registerToolTip(this.dynamicRendererValue, SettingsConfigHelper.DYNAMIC_RENDERER);
        registerToolTip(this.DRR_AUTOSCALER_ENABLEDCheckbox, SettingsConfigHelper.DRR_AUTOSCALER_ENABLED);
        registerToolTip(this.autodetectQuality, SettingsConfigHelper.AUTODETECT_BUTTON);
        registerToolTip(this.monitorDropDown, SettingsConfigHelper.MONITOR);
        registerToolTip(this.monitorLabel, SettingsConfigHelper.MONITOR);
        registerToolTip(this.sizesDropDown, SettingsConfigHelper.SIZE);
        registerToolTip(this.sizesLabel, SettingsConfigHelper.SIZE);
        registerToolTip(this.refreshRateDropDown, SettingsConfigHelper.REFRESH_RATE);
        registerToolTip(this.refreshRateLabel, SettingsConfigHelper.REFRESH_RATE);
        registerToolTip(this.aspectRatioDropDown, SettingsConfigHelper.ASPECTRATIO);
        registerToolTip(this.aspectRatioLabel, SettingsConfigHelper.ASPECTRATIO);
        registerToolTip(this.interfaceScaleDropDown, SettingsConfigHelper.INTERFACE_SCALE);
        registerToolTip(this.interfaceScaleLabel, SettingsConfigHelper.INTERFACE_SCALE);
        registerToolTip(this.smoothingDropDown, SettingsConfigHelper.SMOOTHING);
        registerToolTip(this.smoothingLabel, SettingsConfigHelper.SMOOTHING);
        registerToolTip(this.fullScreenCheckbox, SettingsConfigHelper.FULL_SCREEN);
        registerToolTip(this.vertSyncCheckbox, SettingsConfigHelper.VERTICAL_SYNC);
        registerToolTip(this.tripleBufferedCheckbox, SettingsConfigHelper.TRIPLE_BUFFERED);
        registerToolTip(this.isColorBlindCheckbox, SettingsConfigHelper.IS_COLOR_BLIND);
        registerToolTip(this.gammaSlider, SettingsConfigHelper.GAMMA);
        registerToolTip(this.gammaLabel, SettingsConfigHelper.GAMMA);
        registerToolTip(this.fovRangeSlider, SettingsConfigHelper.FOV);
        registerToolTip(this.fovLabel, SettingsConfigHelper.FOV);
        registerToolTip(this.dynamicFovCheckbox, SettingsConfigHelper.DYNAMIC_FOV);
        registerToolTip(this.HAVOK_ENABLEDDropDown, SettingsConfigHelper.HAVOK_ENABLED);
        registerToolTip(this.HAVOK_ENABLEDLabel, SettingsConfigHelper.HAVOK_ENABLED);
        registerToolTip(this.COLOR_GRADING_TECHNIQUEDropDown, SettingsConfigHelper.COLOR_GRADING_TECHNIQUE);
        registerToolTip(this.COLOR_GRADING_TECHNIQUELabel, SettingsConfigHelper.COLOR_GRADING_TECHNIQUE);
        registerToolTip(this.colorFilterIntensitySlider, SettingsConfigHelper.COLOR_FILTER_INTENSITY);
        registerToolTip(this.colorFilterIntensityLabel, SettingsConfigHelper.COLOR_FILTER_INTENSITY);
        registerToolTip(this.colorFilterIntensityValue, SettingsConfigHelper.COLOR_FILTER_INTENSITY);
        registerToolTip(this.RENDER_PIPELINEButtonBar, SettingsConfigHelper.RENDER_PIPELINE);
        registerToolTip(this.RENDER_PIPELINELabel, SettingsConfigHelper.RENDER_PIPELINE);
        registerToolTip(this.TEXTURE_QUALITYLabel, SettingsConfigHelper.TEXTURE_QUALITY);
        registerToolTip(this.TEXTURE_QUALITYValue, SettingsConfigHelper.TEXTURE_QUALITY);
        registerToolTip(this.DECALS_QUALITYLabel, SettingsConfigHelper.DECALS_QUALITY);
        registerToolTip(this.DECALS_QUALITYValue, SettingsConfigHelper.DECALS_QUALITY);
        registerToolTip(this.SHADOWS_QUALITYLabel, SettingsConfigHelper.SHADOWS_QUALITY);
        registerToolTip(this.SHADOWS_QUALITYValue, SettingsConfigHelper.SHADOWS_QUALITY);
        registerToolTip(this.TERRAIN_QUALITYLabel, SettingsConfigHelper.TERRAIN_QUALITY);
        registerToolTip(this.TERRAIN_QUALITYValue, SettingsConfigHelper.TERRAIN_QUALITY);
        registerToolTip(this.WATER_QUALITYLabel, SettingsConfigHelper.WATER_QUALITY);
        registerToolTip(this.WATER_QUALITYValue, SettingsConfigHelper.WATER_QUALITY);
        registerToolTip(this.LIGHTING_QUALITYLabel, SettingsConfigHelper.LIGHTING_QUALITY);
        registerToolTip(this.LIGHTING_QUALITYValue, SettingsConfigHelper.LIGHTING_QUALITY);
        registerToolTip(this.SPEEDTREE_QUALITYLabel, SettingsConfigHelper.SPEEDTREE_QUALITY);
        registerToolTip(this.SPEEDTREE_QUALITYValue, SettingsConfigHelper.SPEEDTREE_QUALITY);
        registerToolTip(this.FLORA_QUALITYLabel, SettingsConfigHelper.FLORA_QUALITY);
        registerToolTip(this.FLORA_QUALITYValue, SettingsConfigHelper.FLORA_QUALITY);
        registerToolTip(this.EFFECTS_QUALITYLabel, SettingsConfigHelper.EFFECTS_QUALITY);
        registerToolTip(this.EFFECTS_QUALITYValue, SettingsConfigHelper.EFFECTS_QUALITY);
        registerToolTip(this.POST_PROCESSING_QUALITYLabel, SettingsConfigHelper.POST_PROCESSING_QUALITY);
        registerToolTip(this.POST_PROCESSING_QUALITYValue, SettingsConfigHelper.POST_PROCESSING_QUALITY);
        registerToolTip(this.MOTION_BLUR_QUALITYLabel, SettingsConfigHelper.MOTION_BLUR_QUALITY);
        registerToolTip(this.MOTION_BLUR_QUALITYValue, SettingsConfigHelper.MOTION_BLUR_QUALITY);
        registerToolTip(this.FAR_PLANELabel, SettingsConfigHelper.FAR_PLANE);
        registerToolTip(this.FAR_PLANEValue, SettingsConfigHelper.FAR_PLANE);
        registerToolTip(this.OBJECT_LODLabel, SettingsConfigHelper.OBJECT_LOD);
        registerToolTip(this.OBJECT_LODValue, SettingsConfigHelper.OBJECT_LOD);
        registerToolTip(this.SNIPER_MODE_EFFECTS_QUALITYLabel, SettingsConfigHelper.SNIPER_MODE_EFFECTS_QUALITY);
        registerToolTip(this.SNIPER_MODE_EFFECTS_QUALITYValue, SettingsConfigHelper.SNIPER_MODE_EFFECTS_QUALITY);
        registerToolTip(this.fpsPerfomancerCheckbox, SettingsConfigHelper.FPS_PERFORMANCER);
        registerToolTip(this.SNIPER_MODE_GRASS_ENABLEDCheckbox, SettingsConfigHelper.SNIPER_MODE_GRASS_ENABLED);
        registerToolTip(this.VEHICLE_DUST_ENABLEDCheckbox, SettingsConfigHelper.VEHICLE_DUST_ENABLED);
        registerToolTip(this.VEHICLE_TRACES_ENABLEDCheckbox, SettingsConfigHelper.VEHICLE_TRACES_ENABLED);
        registerToolTip(this.SEMITRANSPARENT_LEAVES_ENABLEDCheckbox, SettingsConfigHelper.SEMITRANSPARENT_LEAVES_ENABLED);
        registerToolTip(this.graphicsQualityHDSD, SettingsConfigHelper.GRAPHIC_QUALITY_HDSD);
    }

    private function initControls():void {
        this.monitorLabel = this.screenForm.monitorLabel;
        this.monitorDropDown = this.screenForm.monitorDropDown;
        this.fullScreenCheckbox = this.screenForm.fullScreenCheckbox;
        this.sizesLabel = this.screenForm.sizesLabel;
        this.sizesDropDown = this.screenForm.sizesDropDown;
        this.refreshRateLabel = this.screenForm.refreshRateLabel;
        this.refreshRateDropDown = this.screenForm.refreshRateDropDown;
        this.vertSyncCheckbox = this.screenForm.vertSyncCheckbox;
        this.tripleBufferedCheckbox = this.screenForm.tripleBufferedCheckbox;
        this.aspectRatioLabel = this.screenForm.aspectRatioLabel;
        this.aspectRatioDropDown = this.screenForm.aspectRatioDropDown;
        this.interfaceScaleLabel = this.screenForm.interfaceScaleLabel;
        this.interfaceScaleDropDown = this.screenForm.interfaceScaleDropDown;
        this.smoothingLabel = this.screenForm.smoothingLabel;
        this.smoothingDropDown = this.screenForm.smoothingDropDown;
        this.gammaLabel = this.screenForm.gammaLabel;
        this.gammaSlider = this.screenForm.gammaSlider;
        this.colorFilterIntensityLabel = this.screenForm.colorFilterIntensityLabel;
        this.colorFilterIntensitySlider = this.screenForm.colorFilterIntensitySlider;
        this.colorFilterIntensityValue = this.screenForm.colorFilterIntensityValue;
        this.isColorBlindCheckbox = this.screenForm.isColorBlindCheckbox;
        this.colorFilterDefaultImg = this.screenForm.colorFilterDefaultImg;
        this.colorFilterOverlayImg = this.screenForm.colorFilterOverlayImg;
        this.COLOR_GRADING_TECHNIQUELabel = this.screenForm.COLOR_GRADING_TECHNIQUELabel;
        this.COLOR_GRADING_TECHNIQUEDropDown = this.screenForm.COLOR_GRADING_TECHNIQUEDropDown;
        this.fovLabel = this.screenForm.fovLabel;
        this.fovRangeSlider = this.screenForm.fovRangeSlider;
        this.dynamicFovCheckbox = this.screenForm.dynamicFovCheckbox;
        this.HAVOK_ENABLEDDropDown = this.screenForm.HAVOK_ENABLEDDropDown;
        this.HAVOK_ENABLEDLabel = this.screenForm.HAVOK_ENABLEDLabel;
        var _loc1_:AdvancedGraphicContentForm = this.advancedForm.scrollPane.target as AdvancedGraphicContentForm;
        this.RENDER_PIPELINELabel = _loc1_.RENDER_PIPELINELabel;
        this.RENDER_PIPELINEButtonBar = _loc1_.RENDER_PIPELINEButtonBar;
        this.TEXTURE_QUALITYLabel = _loc1_.TEXTURE_QUALITYLabel;
        this.TEXTURE_QUALITYValue = _loc1_.TEXTURE_QUALITYValue;
        this.TEXTURE_QUALITYStepSlider = _loc1_.TEXTURE_QUALITYStepSlider;
        this.SHADOWS_QUALITYLabel = _loc1_.SHADOWS_QUALITYLabel;
        this.SHADOWS_QUALITYValue = _loc1_.SHADOWS_QUALITYValue;
        this.SHADOWS_QUALITYStepSlider = _loc1_.SHADOWS_QUALITYStepSlider;
        this.DECALS_QUALITYLabel = _loc1_.DECALS_QUALITYLabel;
        this.DECALS_QUALITYValue = _loc1_.DECALS_QUALITYValue;
        this.DECALS_QUALITYStepSlider = _loc1_.DECALS_QUALITYStepSlider;
        this.TERRAIN_QUALITYLabel = _loc1_.TERRAIN_QUALITYLabel;
        this.TERRAIN_QUALITYValue = _loc1_.TERRAIN_QUALITYValue;
        this.TERRAIN_QUALITYStepSlider = _loc1_.TERRAIN_QUALITYStepSlider;
        this.WATER_QUALITYLabel = _loc1_.WATER_QUALITYLabel;
        this.WATER_QUALITYValue = _loc1_.WATER_QUALITYValue;
        this.WATER_QUALITYStepSlider = _loc1_.WATER_QUALITYStepSlider;
        this.LIGHTING_QUALITYLabel = _loc1_.LIGHTING_QUALITYLabel;
        this.LIGHTING_QUALITYValue = _loc1_.LIGHTING_QUALITYValue;
        this.LIGHTING_QUALITYStepSlider = _loc1_.LIGHTING_QUALITYStepSlider;
        this.SPEEDTREE_QUALITYLabel = _loc1_.SPEEDTREE_QUALITYLabel;
        this.SPEEDTREE_QUALITYValue = _loc1_.SPEEDTREE_QUALITYValue;
        this.SPEEDTREE_QUALITYStepSlider = _loc1_.SPEEDTREE_QUALITYStepSlider;
        this.FLORA_QUALITYLabel = _loc1_.FLORA_QUALITYLabel;
        this.FLORA_QUALITYValue = _loc1_.FLORA_QUALITYValue;
        this.FLORA_QUALITYStepSlider = _loc1_.FLORA_QUALITYStepSlider;
        this.EFFECTS_QUALITYLabel = _loc1_.EFFECTS_QUALITYLabel;
        this.EFFECTS_QUALITYValue = _loc1_.EFFECTS_QUALITYValue;
        this.EFFECTS_QUALITYStepSlider = _loc1_.EFFECTS_QUALITYStepSlider;
        this.POST_PROCESSING_QUALITYLabel = _loc1_.POST_PROCESSING_QUALITYLabel;
        this.POST_PROCESSING_QUALITYValue = _loc1_.POST_PROCESSING_QUALITYValue;
        this.POST_PROCESSING_QUALITYStepSlider = _loc1_.POST_PROCESSING_QUALITYStepSlider;
        this.MOTION_BLUR_QUALITYLabel = _loc1_.MOTION_BLUR_QUALITYLabel;
        this.MOTION_BLUR_QUALITYValue = _loc1_.MOTION_BLUR_QUALITYValue;
        this.MOTION_BLUR_QUALITYStepSlider = _loc1_.MOTION_BLUR_QUALITYStepSlider;
        this.FAR_PLANELabel = _loc1_.FAR_PLANELabel;
        this.FAR_PLANEValue = _loc1_.FAR_PLANEValue;
        this.FAR_PLANEStepSlider = _loc1_.FAR_PLANEStepSlider;
        this.OBJECT_LODLabel = _loc1_.OBJECT_LODLabel;
        this.OBJECT_LODValue = _loc1_.OBJECT_LODValue;
        this.OBJECT_LODStepSlider = _loc1_.OBJECT_LODStepSlider;
        this.SNIPER_MODE_EFFECTS_QUALITYLabel = _loc1_.SNIPER_MODE_EFFECTS_QUALITYLabel;
        this.SNIPER_MODE_EFFECTS_QUALITYValue = _loc1_.SNIPER_MODE_EFFECTS_QUALITYValue;
        this.SNIPER_MODE_EFFECTS_QUALITYStepSlider = _loc1_.SNIPER_MODE_EFFECTS_QUALITYStepSlider;
        this.fpsPerfomancerCheckbox = _loc1_.fpsPerfomancerCheckbox;
        this.SNIPER_MODE_GRASS_ENABLEDCheckbox = _loc1_.SNIPER_MODE_GRASS_ENABLEDCheckbox;
        this.VEHICLE_DUST_ENABLEDCheckbox = _loc1_.VEHICLE_DUST_ENABLEDCheckbox;
        this.VEHICLE_TRACES_ENABLEDCheckbox = _loc1_.VEHICLE_TRACES_ENABLEDCheckbox;
        this.SEMITRANSPARENT_LEAVES_ENABLEDCheckbox = _loc1_.SEMITRANSPARENT_LEAVES_ENABLEDCheckbox;
    }
}
}
