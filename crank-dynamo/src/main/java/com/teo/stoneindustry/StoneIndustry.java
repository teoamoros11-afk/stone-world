package com.teo.stoneindustry;

import com.teo.stoneindustry.block.ModBlocks;
import com.teo.stoneindustry.block.entity.ModBlockEntities;
import net.minecraft.world.item.CreativeModeTabs;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.ModContainer;
import net.neoforged.fml.common.Mod;
import net.neoforged.neoforge.capabilities.Capabilities;
import net.neoforged.neoforge.capabilities.RegisterCapabilitiesEvent;
import net.neoforged.neoforge.event.BuildCreativeModeTabContentsEvent;

@Mod(StoneIndustry.MODID)
public class StoneIndustry {

    public static final String MODID = "stoneindustry";

    public StoneIndustry(IEventBus modEventBus, ModContainer modContainer) {
        ModBlockEntities.register(modEventBus);
        ModBlocks.register(modEventBus);
        modEventBus.addListener(this::registerCapabilities);
        modEventBus.addListener(this::addToCreativeTabs);
    }

    /** El bloque expone energia NeoForge para cualquier cable o maquina del pack. */
    private void registerCapabilities(RegisterCapabilitiesEvent event) {
        event.registerBlockEntity(Capabilities.EnergyStorage.BLOCK,
                ModBlockEntities.CRANK_DYNAMO.get(),
                (blockEntity, side) -> blockEntity.getEnergy());
    }

    private void addToCreativeTabs(BuildCreativeModeTabContentsEvent event) {
        if (event.getTabKey() == CreativeModeTabs.REDSTONE_BLOCKS) {
            event.accept(ModBlocks.CRANK_DYNAMO_ITEM);
        }
    }
}
