package com.teo.stonepharmacy;

import com.teo.stonepharmacy.item.ModItems;
import net.minecraft.world.item.CreativeModeTabs;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.ModContainer;
import net.neoforged.fml.common.Mod;
import net.neoforged.neoforge.event.BuildCreativeModeTabContentsEvent;

/**
 * Stone Pharmacy: la farmacia del Reino de la Ciencia.
 *
 * La serie resuelve las infecciones con sulfamidas; el pack no tenia nada para eso.
 * Este mod solo anade lo justo: el principio activo y la jeringa que lo aplica.
 */
@Mod(StonePharmacy.MODID)
public class StonePharmacy {

    public static final String MODID = "stonepharmacy";

    public StonePharmacy(IEventBus modEventBus, ModContainer modContainer) {
        ModItems.register(modEventBus);
        modEventBus.addListener(this::addToCreativeTabs);
    }

    private void addToCreativeTabs(BuildCreativeModeTabContentsEvent event) {
        if (event.getTabKey() == CreativeModeTabs.INGREDIENTS) {
            event.accept(ModItems.SULFAMIDA.get());
        }
        if (event.getTabKey() == CreativeModeTabs.TOOLS_AND_UTILITIES) {
            event.accept(ModItems.JERINGA.get());
        }
    }
}
