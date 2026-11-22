package com.teo.stoneindustry.block.entity;

import com.teo.stoneindustry.StoneIndustry;
import com.teo.stoneindustry.block.ModBlocks;
import net.minecraft.core.registries.Registries;
import net.minecraft.world.level.block.entity.BlockEntityType;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredHolder;
import net.neoforged.neoforge.registries.DeferredRegister;

public class ModBlockEntities {

    public static final DeferredRegister<BlockEntityType<?>> BLOCK_ENTITIES =
            DeferredRegister.create(Registries.BLOCK_ENTITY_TYPE, StoneIndustry.MODID);

    public static final DeferredHolder<BlockEntityType<?>, BlockEntityType<CrankDynamoBlockEntity>> CRANK_DYNAMO =
            BLOCK_ENTITIES.register("crank_dynamo", () -> BlockEntityType.Builder
                    .of(CrankDynamoBlockEntity::new, ModBlocks.CRANK_DYNAMO.get())
                    .build(null));

    public static void register(IEventBus modEventBus) {
        BLOCK_ENTITIES.register(modEventBus);
    }
}
