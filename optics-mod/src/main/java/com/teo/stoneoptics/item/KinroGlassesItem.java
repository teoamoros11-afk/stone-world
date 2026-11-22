package com.teo.stoneoptics.item;

import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResultHolder;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.Level;

/**
 * Gafas de Kinro: el guardia miope ve por primera vez.
 * Aqui dan vision clara (vision nocturna) un rato y luego hay que limpiarlas.
 */
public class KinroGlassesItem extends Item {

    private static final int DURACION = 1200;   // 60 s de vision clara
    private static final int ENFRIAMIENTO = 240; // 12 s limpiando los cristales

    public KinroGlassesItem(Properties properties) {
        super(properties);
    }

    @Override
    public InteractionResultHolder<ItemStack> use(Level level, Player player, InteractionHand hand) {
        ItemStack stack = player.getItemInHand(hand);
        player.addEffect(new MobEffectInstance(MobEffects.NIGHT_VISION, DURACION, 0, false, true));
        player.getCooldowns().addCooldown(this, ENFRIAMIENTO);
        level.playSound(null, player.getX(), player.getY(), player.getZ(),
                SoundEvents.ARMOR_EQUIP_GENERIC, SoundSource.PLAYERS, 0.6F, 1.3F);
        return InteractionResultHolder.success(stack);
    }
}
