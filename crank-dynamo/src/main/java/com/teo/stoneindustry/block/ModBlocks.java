package com.teo.stoneindustry.block;

import com.teo.stoneindustry.StoneIndustry;
import net.minecraft.world.item.BlockItem;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.SoundType;
import net.minecraft.world.level.block.state.BlockBehaviour;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredBlock;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

public class ModBlocks {

    public static final DeferredRegister.Blocks BLOCKS =
            DeferredRegister.createBlocks(StoneIndustry.MODID);

    public static final DeferredRegister.Items ITEMS =
            DeferredRegister.createItems(StoneIndustry.MODID);

    /** Dinamo de manivela: dos manos girando dan electricidad a la aldea. */
    public static final DeferredBlock<Block> CRANK_DYNAMO = BLOCKS.registerBlock(
            "crank_dynamo",
            CrankDynamoBlock::new,
            BlockBehaviour.Properties.of()
                    .strength(3.0F, 6.0F)
                    .sound(SoundType.METAL)
                    .requiresCorrectToolForDrops());

    public static final DeferredItem<BlockItem> CRANK_DYNAMO_ITEM =
            ITEMS.register("crank_dynamo",
                    () -> new BlockItem(CRANK_DYNAMO.get(), new Item.Properties()));

    public static void register(IEventBus modEventBus) {
        BLOCKS.register(modEventBus);
        ITEMS.register(modEventBus);
    }
}
