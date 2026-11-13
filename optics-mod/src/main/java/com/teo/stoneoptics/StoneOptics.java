package com.teo.stoneoptics;

import com.teo.stoneoptics.item.ModItems;
import net.minecraft.world.item.CreativeModeTabs;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.ModContainer;
import net.neoforged.fml.common.Mod;
import net.neoforged.neoforge.event.BuildCreativeModeTabContentsEvent;

@Mod(StoneOptics.MODID)
public class StoneOptics {

    public static final String MODID = "stoneoptics";

    public StoneOptics(IEventBus modEventBus, ModContainer modContainer) {
        ModItems.register(modEventBus);
        modEventBus.addListener(this::addToCreativeTabs);
    }

    private void addToCreativeTabs(BuildCreativeModeTabContentsEvent event) {
        if (event.getTabKey() == CreativeModeTabs.TOOLS_AND_UTILITIES) {
            event.accept(ModItems.TELESCOPE);
            event.accept(ModItems.POLISHED_LENS);
            event.accept(ModItems.ROUGH_LENS);
        }
    }
}
