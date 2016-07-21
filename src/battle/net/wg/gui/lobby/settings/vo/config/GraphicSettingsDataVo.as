package net.wg.gui.lobby.settings.vo.config {
import net.wg.gui.lobby.settings.config.ControlsFactory;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;

public class GraphicSettingsDataVo extends SettingsDataVo {

    public var monitor:SettingsControlProp = null;

    public var aspectRatio:SettingsControlProp = null;

    public var smoothing:SettingsControlProp = null;

    public var customAA:SettingsControlProp = null;

    public var multisampling:SettingsControlProp = null;

    public var gamma:SettingsControlProp = null;

    public var sizes:SettingsControlProp = null;

    public var windowSize:SettingsControlProp = null;

    public var resolution:SettingsControlProp = null;

    public var refreshRate:SettingsControlProp = null;

    public var interfaceScale:SettingsControlProp = null;

    public var dynamicRenderer:SettingsControlProp = null;

    public var fov:SettingsControlProp = null;

    public var dynamicFov:SettingsControlProp = null;

    public var HAVOK_ENABLED:SettingsControlProp = null;

    public var colorFilterIntensity:SettingsControlProp = null;

    public var fullScreen:SettingsControlProp = null;

    public var vertSync:SettingsControlProp = null;

    public var tripleBuffered:SettingsControlProp = null;

    public var isColorBlind:SettingsControlProp = null;

    public var graphicsQuality:SettingsControlProp = null;

    public var graphicsQualityHDSD:SettingsControlProp = null;

    public var RENDER_PIPELINE:SettingsControlProp = null;

    public var TEXTURE_QUALITY:SettingsControlProp = null;

    public var DECALS_QUALITY:SettingsControlProp = null;

    public var SHADOWS_QUALITY:SettingsControlProp = null;

    public var TERRAIN_QUALITY:SettingsControlProp = null;

    public var WATER_QUALITY:SettingsControlProp = null;

    public var LIGHTING_QUALITY:SettingsControlProp = null;

    public var SPEEDTREE_QUALITY:SettingsControlProp = null;

    public var FLORA_QUALITY:SettingsControlProp = null;

    public var EFFECTS_QUALITY:SettingsControlProp = null;

    public var POST_PROCESSING_QUALITY:SettingsControlProp = null;

    public var MOTION_BLUR_QUALITY:SettingsControlProp = null;

    public var FAR_PLANE:SettingsControlProp = null;

    public var OBJECT_LOD:SettingsControlProp = null;

    public var SNIPER_MODE_EFFECTS_QUALITY:SettingsControlProp = null;

    public var COLOR_GRADING_TECHNIQUE:SettingsControlProp = null;

    public var fpsPerfomancer:SettingsControlProp = null;

    public var SNIPER_MODE_GRASS_ENABLED:SettingsControlProp = null;

    public var VEHICLE_DUST_ENABLED:SettingsControlProp = null;

    public var VEHICLE_TRACES_ENABLED:SettingsControlProp = null;

    public var DRR_AUTOSCALER_ENABLED:SettingsControlProp = null;

    public var SEMITRANSPARENT_LEAVES_ENABLED:SettingsControlProp = null;

    public var presets:SettingsDataVo = null;

    public var qualityOrder:Vector.<String> = null;

    public var colorFilterImages:Vector.<String> = null;

    public var hash:Object;

    public function GraphicSettingsDataVo() {
        super(this.hash = {
            "monitor": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "aspectRatio": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "smoothing": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "customAA": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "multisampling": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "gamma": createControl(ControlsFactory.TYPE_SLIDER).build(),
            "sizes": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "windowSize": createControl(ControlsFactory.TYPE_DROPDOWN).readOnly(true).build(),
            "resolution": createControl(ControlsFactory.TYPE_DROPDOWN).readOnly(true).build(),
            "refreshRate": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "interfaceScale": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "dynamicRenderer": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "fov": createControl(ControlsFactory.TYPE_RANGE_SLIDER).build(),
            "dynamicFov": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "HAVOK_ENABLED": createControl(ControlsFactory.TYPE_DROPDOWN).hasLabel(true).isDataAsSelectedIndex(true).build(),
            "colorFilterIntensity": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "colorFilterImages": new Vector.<String>(),
            "fullScreen": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "vertSync": createControl(ControlsFactory.TYPE_CHECKBOX).isDependOn(SettingsConfigHelper.TRIPLE_BUFFERED).build(),
            "tripleBuffered": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "isColorBlind": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "graphicsQuality": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "graphicsQualityHDSD": createControl(ControlsFactory.TYPE_LABEL).build(),
            "RENDER_PIPELINE": createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "TEXTURE_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "DECALS_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "SHADOWS_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "TERRAIN_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "WATER_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "LIGHTING_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "SPEEDTREE_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "FLORA_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "EFFECTS_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "POST_PROCESSING_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "MOTION_BLUR_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "FAR_PLANE": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "OBJECT_LOD": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "SNIPER_MODE_EFFECTS_QUALITY": createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "COLOR_GRADING_TECHNIQUE": createControl(ControlsFactory.TYPE_DROPDOWN).hasLabel(true).build(),
            "fpsPerfomancer": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "SNIPER_MODE_GRASS_ENABLED": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "VEHICLE_DUST_ENABLED": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "VEHICLE_TRACES_ENABLED": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "DRR_AUTOSCALER_ENABLED": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "SEMITRANSPARENT_LEAVES_ENABLED": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "qualityOrder": new Vector.<String>(),
            "presets": null
        });
    }
}
}
