package com.teo.stoneoptics.block;

import com.teo.stoneoptics.StoneOptics;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.SoundType;
import net.minecraft.world.level.block.state.BlockBehaviour;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredBlock;
import net.neoforged.neoforge.registries.DeferredRegister;

public class ModBlocks {

    public static final DeferredRegister.Blocks BLOCKS =
            DeferredRegister.createBlocks(StoneOptics.MODID);

    /** Banco de pulido: el taller donde la lente turbia se vuelve util. */
    public static final DeferredBlock<Block> POLISHING_TABLE = BLOCKS.registerBlock(
            "polishing_table",
            PolishingTableBlock::new,
            BlockBehaviour.Properties.of().strength(2.0F, 3.0F).sound(SoundType.WOOD));

    public static void register(IEventBus modEventBus) {
        BLOCKS.register(modEventBus);
    }
}
