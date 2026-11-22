package com.teo.stoneoptics.block;

import com.teo.stoneoptics.item.ModItems;
import net.minecraft.core.BlockPos;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.ItemInteractionResult;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.BlockHitResult;

/**
 * Banco de pulido. En la serie el pulido es un banco de trabajo con abrasivo y agua,
 * no una receta de mesa: aqui se le da la lente sin pulir y devuelve la pulida.
 */
public class PolishingTableBlock extends Block {

    public PolishingTableBlock(Properties properties) {
        super(properties);
    }

    @Override
    protected ItemInteractionResult useItemOn(ItemStack stack, BlockState state, Level level,
                                              BlockPos pos, Player player, InteractionHand hand,
                                              BlockHitResult hit) {
        if (!stack.is(ModItems.ROUGH_LENS.get())) {
            return ItemInteractionResult.PASS_TO_DEFAULT_BLOCK_INTERACTION;
        }
        if (!level.isClientSide) {
            if (!player.hasInfiniteMaterials()) {
                stack.shrink(1);
            }
            player.getInventory().placeItemBackInInventory(new ItemStack(ModItems.POLISHED_LENS.get()));
            level.playSound(null, pos, SoundEvents.SAND_BREAK, SoundSource.BLOCKS, 0.9F, 1.4F);
        }
        return ItemInteractionResult.SUCCESS;
    }
}
