package com.teo.stoneindustry.block;

import com.mojang.serialization.MapCodec;
import com.teo.stoneindustry.block.entity.CrankDynamoBlockEntity;
import com.teo.stoneindustry.block.entity.ModBlockEntities;
import net.minecraft.core.BlockPos;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.block.BaseEntityBlock;
import net.minecraft.world.level.block.RenderShape;
import net.minecraft.world.level.block.entity.BlockEntity;
import net.minecraft.world.level.block.entity.BlockEntityTicker;
import net.minecraft.world.level.block.entity.BlockEntityType;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.BlockHitResult;
import org.jetbrains.annotations.Nullable;

/**
 * Dinamo de manivela. Clic derecho = girar: mientras queden vueltas, el bloque mete
 * energia en su buffer y cualquier maquina del pack puede extraerla.
 */
public class CrankDynamoBlock extends BaseEntityBlock {

    public CrankDynamoBlock(Properties properties) {
        super(properties);
    }

    @Override
    protected MapCodec<? extends BaseEntityBlock> codec() {
        return simpleCodec(CrankDynamoBlock::new);
    }

    @Override
    protected RenderShape getRenderShape(BlockState state) {
        return RenderShape.MODEL;
    }

    @Nullable
    @Override
    public BlockEntity newBlockEntity(BlockPos pos, BlockState state) {
        return new CrankDynamoBlockEntity(pos, state);
    }

    @Nullable
    @Override
    public <T extends BlockEntity> BlockEntityTicker<T> getTicker(Level level, BlockState state,
                                                                 BlockEntityType<T> type) {
        if (level.isClientSide) {
            return null;
        }
        return (lvl, pos, st, be) -> {
            if (be instanceof CrankDynamoBlockEntity dynamo) {
                dynamo.serverTick();
            }
        };
    }

    @Override
    protected InteractionResult useWithoutItem(BlockState state, Level level, BlockPos pos,
                                               Player player, BlockHitResult hit) {
        if (!level.isClientSide && level.getBlockEntity(pos) instanceof CrankDynamoBlockEntity dynamo) {
            dynamo.crank();
            level.playSound(null, pos, SoundEvents.WOODEN_BUTTON_CLICK_ON,
                    SoundSource.BLOCKS, 0.8F, 0.7F);
        }
        return InteractionResult.sidedSuccess(level.isClientSide);
    }
}
