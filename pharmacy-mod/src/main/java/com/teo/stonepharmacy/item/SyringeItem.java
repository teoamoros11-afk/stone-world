package com.teo.stonepharmacy.item;

import net.minecraft.network.chat.Component;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResultHolder;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.Level;

/**
 * Jeringa con sulfamida.
 *
 * No cura la petrificacion (eso es el fluido milagroso): cura lo que mataba a la gente
 * antes de la penicilina, que es exactamente lo que la serie resuelve con sulfamidas.
 */
public class SyringeItem extends Item {

    public SyringeItem(Properties properties) {
        super(properties);
    }

    @Override
    public InteractionResultHolder<ItemStack> use(Level level, Player player, InteractionHand hand) {
        ItemStack stack = player.getItemInHand(hand);
        if (!level.isClientSide) {
            boolean curado = player.removeEffect(MobEffects.POISON);
            curado |= player.removeEffect(MobEffects.WITHER);
            // en 1.21.1 la nausea se registra como nausea pero la constante se llama CONFUSION
            curado |= player.removeEffect(MobEffects.CONFUSION);
            curado |= player.removeEffect(MobEffects.WEAKNESS);

            player.heal(curado ? 6.0F : 2.0F);
            level.playSound(null, player.blockPosition(), SoundEvents.BREWING_STAND_BREW,
                    SoundSource.PLAYERS, 0.8F, 1.5F);
            player.displayClientMessage(Component.translatable(curado
                    ? "item.stonepharmacy.jeringa.curado"
                    : "item.stonepharmacy.jeringa.sano"), true);

            if (!player.getAbilities().instabuild) {
                stack.shrink(1);
            }
            player.getCooldowns().addCooldown(this, 40);
        }
        return InteractionResultHolder.sidedSuccess(stack, level.isClientSide());
    }
}
