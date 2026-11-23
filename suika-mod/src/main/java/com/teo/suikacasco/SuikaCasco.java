package com.teo.suikacasco;

import com.teo.suikacasco.item.ModItems;
import net.minecraft.world.item.CreativeModeTabs;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.ModContainer;
import net.neoforged.fml.common.Mod;
import net.neoforged.neoforge.event.BuildCreativeModeTabContentsEvent;

@Mod(SuikaCasco.MODID)
public class SuikaCasco {

    public static final String MODID = "suikacasco";

    public SuikaCasco(IEventBus modEventBus, ModContainer modContainer) {
        ModItems.register(modEventBus);
        modEventBus.addListener(this::addToCreativeTabs);
    }

    private void addToCreativeTabs(BuildCreativeModeTabContentsEvent event) {
        if (event.getTabKey() == CreativeModeTabs.COMBAT) {
            event.accept(ModItems.WATERMELON_HELMET);
        }
    }
}
